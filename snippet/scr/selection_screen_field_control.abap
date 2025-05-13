*------------------------------------------------------------*
* Dynamically toggle selection screen fields based on radio button.
* Notes:
* - CH_BOX is placed in the same block but rendered below the radio buttons.
* - CH_BOX becomes invisible when RDO3 is selected.
*------------------------------------------------------------*

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.

    " Disable fields based on selected radio button
    CASE 'X'.
      WHEN RDO1. " Radio option 1 selected
        IF SCREEN-GROUP1 = 'GR2' OR SCREEN-GROUP1 = 'GR3'.
          SCREEN-ACTIVE = '0'. " Disable group 2 and 3
        ENDIF.
      WHEN RDO2. " Radio option 2 selected
        IF SCREEN-GROUP1 = 'GR1' OR SCREEN-GROUP1 = 'GR3'.
          SCREEN-ACTIVE = '0'. " Disable group 1 and 3
        ENDIF.
      WHEN RDO3. " Radio option 3 selected
        IF SCREEN-GROUP1 = 'GR1' OR SCREEN-GROUP1 = 'GR2'.
          SCREEN-ACTIVE = '0'. " Disable group 1 and 2
        ENDIF.
    ENDCASE.

    " Hide the checkbox when RDO3 is selected
    IF RDO3 = 'X' AND SCREEN-NAME = 'CH_BOX'.
      SCREEN-INVISIBLE = '1'.
    ENDIF.

    MODIFY SCREEN.
  ENDLOOP.

*------------------------------------------------------------*
* Field layout: position checkbox under radio buttons
*------------------------------------------------------------*
SELECTION-SCREEN SKIP. " Skip one line for readability
PARAMETERS: CH_BOX AS CHECKBOX. " Below radio buttons
SELECTION-SCREEN END OF BLOCK B1.

*------------------------------------------------------------*
* Selection screen field visibility by radio button choice
*------------------------------------------------------------*
*   Radio Button   |   GR1   |   GR2   |   GR3   
 
|   CH_BOX   |

*------------------+---------+---------+---------+------------*
*      RDO1        |   ✔️     |   ❌     |   ❌     |    ✔️ show   |
*      RDO2        |   ❌     |   ✔️     |   ❌     |    ✔️ show   |
*      RDO3        |   ❌     |   ❌     |   ✔️     |    ❌ hide   |
*------------------------------------------------------------*
