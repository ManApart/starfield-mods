# Curable Ailments

- [x] Make Machine constructable
- [x] Make vial constructable
  - Use view in inspector to edit output
- [x] Test administering cure
- [ ] Only run for first item, not every item
- [x] label cure 1, cure 2, cure 3
- [x] High level includes all sub levels
- [ ] Instead of excellent, allow stable or good
- [ ] Make machine require first research project
- [ ] BUild out projects
- [ ] Don't show craftable objects until they can be built




Both cures and the machine have different levels
- level 1 cures lightest, level 3 reduces to level 2 if possible, else cures all
- higher cures require higher medicine

; add brain injury (not working for prognosis)
player.addspell 002bdd18
; add panacea
player.additem 0029a859 10
;injector
player.additem 002f445a 10
player.getav AFFL_PrognosisAV_Infection_BrainInfection


## Constructable Objects

All cures require `ScienceGlass_Vial02` in addition to items in the table



# Item ideas from game

Molecular extractor