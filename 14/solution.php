<?php
$filename = "input.txt";
//$filename = "sample.txt";
$myfile = fopen($filename, "r");
$input = fread($myfile, filesize($filename));
fclose($myfile);

$lines = explode(PHP_EOL, trim($input));

function parse_ingredient($text) {
   return explode(' ', $text);
}

function parse_formula($line) {
  list($ingredients, $result) = explode(" => ", $line);
  $ingr_list = explode(", ", $ingredients);
  $parsed_ingr_list = array_map('parse_ingredient', $ingr_list);
  $parsed_result = parse_ingredient($result);
  return array(
    "ingr" => $parsed_ingr_list,
    "prod" => $parsed_result,
  );
}

function topo_rec($element, &$formulas, &$seen_elements, &$result_list) {
  if (array_key_exists($element, $seen_elements)) return;
  foreach ($formulas[$element]["ingr"] as $kv) {
    topo_rec($kv[1], $formulas, $seen_elements, $result_list);
  }
  $seen_elements[$element] = true;
  array_push($result_list, $element);
}

function topo_sort(&$formulas) {
  // We represent a set as a map to true.
  $seen_elements = array("ORE" => true);
  $result_list = array("ORE");
  topo_rec("FUEL", $formulas, $seen_elements, $result_list);
  $element_order = array();
  foreach ($result_list as $index => $element) {
    $element_order[$element] = $index;
  }
  return $element_order;
}

$formula_list = array_map('parse_formula', $lines);
$formulas = array();
foreach ($formula_list as $f) {
  $formulas[$f["prod"][1]] = $f;
}

// map of element => replacement priority. Higher goes first.
$element_order = topo_sort($formulas);

function needed_ore($fuel_amount, &$element_order, &$formulas) {
  $elements_needed = array_fill(0, count($element_order) - 1, 0);
  // needed fuel
  array_push($elements_needed, $fuel_amount);

  foreach (array_reverse($element_order) as $element=>$index) {
    if ($element == "ORE") break;
    $amount_needed = $elements_needed[$element_order[$element]];
    if ($amount_needed == 0) echo "Error!\n";
    $formula = $formulas[$element];
    $formula_times = ceil($amount_needed / $formula["prod"][0]);
    foreach ($formula["ingr"] as $ingr) {
      $elements_needed [$element_order[$ingr[1]]] += $ingr[0] * $formula_times;
    }
  }
  return $elements_needed[0];
}

$fuel_for_one = needed_ore(1, $element_order, $formulas);

echo "For 1 FUEL: " . $fuel_for_one . "\n";

$max_ore = 1000000000000;

$fuel_amount = ceil($max_ore / $fuel_for_one);

$increment = 1000000;
while ($increment >= 1) {
  while (needed_ore($fuel_amount, $element_order, $formulas) <= $max_ore) {
    $fuel_amount += $increment;
  }
  $fuel_amount -= $increment;
  $increment /= 10;
}

echo "For 1 trillion ore: " . $fuel_amount . "\n";

?>
