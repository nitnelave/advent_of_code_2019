HAI 1.4

CAN HAS STRING?
CAN HAS STDIO?

I HAS A FILENEM ITZ "input.txt"
I HAS A INPUT ITZ A YARN
VISIBLE "WAT IZ INPUT?"
GIMMEH INPUT
VISIBLE "GOT INPUT:: :{INPUT}"

I HAS A FILE ITZ I IZ STDIO'Z OPEN YR FILENEM AN YR "r" MKAY
I IZ STDIO'Z DIAF YR FILE MKAY
O RLY?
  YA RLY
    VISIBLE "WHERE MAH :{FILENEM}?"
  NO WAI
    VISIBLE "THERE'Z MAH FILE!"
OIC

I HAS A PROGRAM ITZ I IZ STDIO'Z LUK YR FILE AN YR 9001 MKAY    BTW ITZ OVER 9000

I HAS A MAX_READ ITZ I IZ STRING'Z LEN YR PROGRAM MKAY

I HAS A MATRXX ITZ A BUKKIT
I HAS A MAX_SPOT ITZ 0
I HAS A FINGA ITZ -1    BTW DAT MAH FINGA TO REED

IM IN YR HEAD UPPIN YR SPOT TIL BOTH SAEM FINGA AN MAX_READ
  FINGA R SUM OF FINGA AN 1
  I HAS A BIT ITZ 0
  I HAS A NEG ITZ FAIL
  BOTH SAEM I IZ STRING'Z AT YR PROGRAM AN YR FINGA MKAY "-"
  O RLY?
    YA RLY
      NEG R WIN
      FINGA R SUM OF FINGA AN 1
  OIC

  IM IN YR BOOK UPPIN YR PAGE TIL ANY OF BOTH SAEM FINGA MAX_READ AN ...
                                         BOTH SAEM I IZ STRING'Z AT YR PROGRAM AN YR FINGA MKAY ":)" AN ...
                                         BOTH SAEM I IZ STRING'Z AT YR PROGRAM AN YR FINGA MKAY "," MKAY
    BIT R PRODUKT OF BIT AN 10
    BIT R SUM OF BIT AN I IZ STRING'Z AT YR PROGRAM AN YR FINGA MKAY
    FINGA R SUM OF FINGA AN 1
  IM OUTTA YR BOOK
  NEG
  O RLY?
    YA RLY
      BIT R DIFF OF 0 AN BIT
  OIC
  MATRXX HAS A SRS SPOT ITZ BIT
  BOTH SAEM I IZ STRING'Z AT YR PROGRAM AN YR FINGA MKAY ":)"
  O RLY?
    YA RLY
      GTFO
  OIC
  MAX_SPOT R SPOT
IM OUTTA YR HEAD

MAX_SPOT R SUM OF MAX_SPOT 2    BTW MAX_SPOT WUZ DA NUMBR OF COMAZ MINUS WON

HOW IZ I GET_IZ_RN YR CODE AN YR COL
  FOUND YR BOTH SAEM MOD OF QUOSHUNT OF CODE AN COL AN 10 AN 1
IF U SAY SO

HOW IZ I MAKIN_A_NUMBR_FROM YR TROOF_
  TROOF_
  O RLY?
    YA RLY
      FOUND YR 1
    NO WAI
      FOUND YR 0
  OIC
IF U SAY SO

HOW IZ I DO_A_BIN_OP YR SPOT AN YR OP
  I HAS A ARG1
  I HAS A ARG2
  I IZ GET_IZ_RN YR ORDER AN YR 100 MKAY
  O RLY?
    YA RLY
      ARG1 R MATRXX'Z SRS SUM OF SPOT AN 1
    NO WAI
      ARG1 R MATRXX'Z SRS MATRXX'Z SRS SUM OF SPOT AN 1
  OIC
  I IZ GET_IZ_RN YR ORDER AN YR 1000 MKAY
  O RLY?
    YA RLY
      ARG2 R MATRXX'Z SRS SUM OF SPOT AN 2
    NO WAI
      ARG2 R MATRXX'Z SRS MATRXX'Z SRS SUM OF SPOT AN 2
  OIC
  I HAS A RES
  OP, WTF?
    OMG 1
      RES R SUM OF ARG1 AN ARG2
      GTFO
    OMG 2
      RES R PRODUKT OF ARG1 AN ARG2
      GTFO
    OMG 7
      RES R I IZ MAKIN_A_NUMBR_FROM YR NOT BOTH SAEM ARG1 AN BIGGR OF ARG1 AN ARG2 MKAY
      GTFO
    OMG 8
      RES R I IZ MAKIN_A_NUMBR_FROM YR BOTH SAEM ARG1 AN ARG2 MKAY
      GTFO
  OIC
  I HAS A DEST_SPOT ITZ MATRXX'Z SRS SUM OF SPOT AN 3
  MATRXX'Z SRS DEST_SPOT R RES
IF U SAY SO

I HAS A EXXT ITZ A TROOF
IM IN YR EGZECUSHUN UPPIN YR SPOT TIL EITHER OF EXXT BOTH SAEM SPOT MAX_SPOT
  I HAS A ORDER ITZ MATRXX'Z SRS SPOT
  I HAS A SICRIT_CODE ITZ MOD OF ORDER 100
  SICRIT_CODE
  WTF?
    OMG 1
    OMG 2
    OMG 7
    OMG 8
      BTW SUM OR MUL
      I IZ DO_A_BIN_OP YR SPOT AN YR SICRIT_CODE MKAY
      SPOT R SUM OF SPOT 3
      GTFO
    OMG 3
      BTW REED
      SPOT R SUM OF SPOT 1
      MATRXX'Z SRS MATRXX'Z SRS SPOT R INPUT     BTW IF DEY REED, GIB INPUT
      GTFO
    OMG 4
      BTW RITE
      SPOT R SUM OF SPOT 1
      I IZ GET_IZ_RN YR ORDER AN YR 100 MKAY
      O RLY?
        YA RLY
          VISIBLE MATRXX'Z SRS SPOT
        NO WAI
          VISIBLE MATRXX'Z SRS MATRXX'Z SRS SPOT
      OIC
      GTFO
    OMG 5
    OMG 6
      BTW JUMP IF WIN/FAIL
      SPOT R SUM OF SPOT 1
      I HAS A I_JUMP ITZ A TROOF
      I IZ GET_IZ_RN YR ORDER AN YR 100 MKAY
      O RLY?
        YA RLY
          I_JUMP R NOT BOTH SAEM MATRXX'Z SRS SPOT AN 0
        NO WAI
          I_JUMP R NOT BOTH SAEM MATRXX'Z SRS MATRXX'Z SRS SPOT AN 0
      OIC
      SPOT R SUM OF SPOT 1
      BOTH SAEM I_JUMP AN BOTH SAEM SICRIT_CODE AN 5
      O RLY?
        YA RLY
          I IZ GET_IZ_RN YR ORDER AN YR 1000 MKAY
          I HAS A TARGIT ITZ A NUMBR
          O RLY?
            YA RLY
              TARGIT R MATRXX'Z SRS SPOT
            NO WAI
              TARGIT R MATRXX'Z SRS MATRXX'Z SRS SPOT
          OIC
          SPOT R DIFF OF TARGIT AN 1
      OIC
      GTFO
    OMG 99
      EXXT R WIN
      GTFO
    OMGWTF
      VISIBLE "I DONT GIT IT:: :{SICRIT_CODE} AT SPOT :{SPOT}"
      GTFO
  OIC
IM OUTTA YR EGZECUSHUN

KTHXBYE

