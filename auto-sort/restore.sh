DATA=/mnt/extradrive1/SteamLibrary/steamapps/common/Starfield/Data
TERMINAL=scripts/source/fragments/terminals
QUESTS=scripts/source/fragments/quests
TERMINAL_DEST=./auto-sort/scripts/fragments/terminals
mkdir -p $DATA/$TERMINAL
mkdir -p $DATA/$QUESTS
cp ./auto-sort/AkAutoSort.esp $DATA/AkAutoSort.esp
cp ./auto-sort/scripts/AKSortTool.psc $DATA/scripts/source/AKSortTool.psc
cp ./auto-sort/scripts/AKAutoSortQuest.psc $DATA/scripts/source/AKAutoSortQuest.psc
cp ./auto-sort/scripts/AKASViewKeywords.psc $DATA/scripts/source/AKASViewKeywords.psc
cp ./auto-sort/scripts/fragments/quests/QF_AKAutoSort_01000806.psc $DATA/$QUESTS/QF_AKAutoSort_01000806.psc
cp $TERMINAL_DEST/TERM_AKASMainMenu_0100083F.psc $DATA/$TERMINAL/TERM_AKASMainMenu_0100083F.psc
cp $TERMINAL_DEST/TERM_AKASTagObjectType_01000E9E.psc $DATA/$TERMINAL/TERM_AKASTagObjectType_01000E9E.psc
cp $TERMINAL_DEST/TERM__01000E9B.psc $DATA/$TERMINAL/TERM__01000E9B.psc
cp $TERMINAL_DEST/TERM__01000EA3.psc $DATA/$TERMINAL/TERM__01000EA3.psc
cp $TERMINAL_DEST/TERM__01000EA4.psc $DATA/$TERMINAL/TERM__01000EA4.psc
cp $TERMINAL_DEST/TERM__01000EA5.psc $DATA/$TERMINAL/TERM__01000EA5.psc
cp $TERMINAL_DEST/TERM__01000EAC.psc $DATA/$TERMINAL/TERM__01000EAC.psc
cp $TERMINAL_DEST/TERM__01000ECD.psc $DATA/$TERMINAL/TERM__01000ECD.psc