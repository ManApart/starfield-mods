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


Batch Research Projects
completeresearch 04000927
```
04000927 'Osteology'
04000928 'Osteology 2'
04000929 'Osteology 3'
04000924 'Neuroptimization'
04000925 'Neuroptimization 2'
04000926 'Neuroptimization 3'
0400092C 'Dermatology'
04000937 'Dermatology 2'
04000938 'Dermatology 3'
0400092E 'Traumatology '
04000940 'Traumatology 2'
04000942 'Traumatology 3'
0400092D 'Thermoregulation'
0400093D 'Thermoregulation 2'
0400093E 'Thermoregulation 3'
0400092A 'Gastroenterology'
04000939 'Gastroenterology 2'
0400093A 'Gastroenterology 3'
0400092B 'Pulmonology '
0400093B 'Pulmonology 2'
0400093C 'Pulmonology 3'
0400092F 'Toxicology '
0400093F 'Toxicology 2'
04000941 'Toxicology 3'
040008C6 'BioMechanics'
04000912 'BioMechanics 2'
04000913 'BioMechanics 3'
04000936 'Kinesiology'
04000943 'Kinesiology 2'
04000944 'Kinesiology 3'
```