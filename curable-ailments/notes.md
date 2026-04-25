# Curable Ailments

- [ ] Make Machine constructable
- [ ] Make vial constructable
  - Blocked: can't assign output of constructable object: Use xedit
- [ ] Make machine require first research project
- [ ] BUild out projects


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


## Research Projects

Name | Projects | Perks | Items
--- | --- | --- | ---
BioMechanics | | Skill_Robotics 1, Skill_Medicine 1 | ScienceGlass_Vial03Closed01Full04 x5, Syringes_01 x5, MedicalScalpel x2
BioMechanics 2 | BioMechanics | Skill_Robotics 2, Skill_Medicine 2, Skill_Chemistry 2 |
BioMechanics 3 | BioMechanics 2 | Skill_Robotics 4, Skill_SpecialProjects 4, Skill_Medicine 4, Skill_Chemistry 4 |
Scientific Production | BioMechanics | Skill_SpecialProjects 2 | Swabs01A x1, KidneyDish01_Base , SurgicalBowl01 x1
Neuroptimization | BioMechanics | |
Neuroptimization 2 | Neuroptimization | |
Neuroptimization 3 | Neuroptimization 2 | |
Osteology | BioMechanics | |
Osteology 2 | Osteology | |
Osteology 3 | Osteology 2 | |
Gastroenterology | BioMechanics | |
Gastroenterology 2 | Gastroenterology | |
Gastroenterology 3 | Gastroenterology 2 | |
Pulmonology | BioMechanics | |
Pulmonology 2 | Pulmonology | |
Pulmonology 3 | Pulmonology 2 | |
Dermatology | BioMechanics | |
Dermatology 2 | Dermatology | |
Dermatology 3 | Dermatology 2 | |
Thermoregulation | BioMechanics | |
Thermoregulation 2 | Thermoregulation | |
Thermoregulation 3 | Thermoregulation 2 | |
Traumatology | BioMechanics | |
Traumatology 2 | Traumatology | |
Traumatology 3 | Traumatology 2 | |
Toxicology | BioMechanics | |
Toxicology 2 | Toxicology | |
Toxicology 3 | Toxicology 2 | |
Radiobiology | BioMechanics | |
Radiobiology 2 | Radiobiology | |
Radiobiology 3 | Radiobiology 2 | |
Kinesiology | BioMechanics | |
Kinesiology 2 | Kinesiology | |
Kinesiology 3 | Kinesiology 2 | |

## Constructable Objects

All cures require `ScienceGlass_Vial02` in addition to items in the table

Result | Project | Items
--- | --- | --
Injector 1 | BioMechanics | Microscope01
Injector 2 | BioMechanics 2 |
Injector 3 | BioMechanics 3 |
Cure - Bone Infection | Osteology |
Cure - Bone Infection 2 | Osteology |
Cure - Bone Infection 3 | Osteology |
Cure - Brain Infection | Neuroptimization |
Cure - Brain Infection 2 | Neuroptimization |
Cure - Brain Infection 3 | Neuroptimization |
Cure - Intestinal Infection | Gastroenterology |
Cure - Intestinal Infection 2 | Gastroenterology |
Cure - Intestinal Infection 3 | Gastroenterology |
Cure - Lung Infection | Pulmonology |
Cure - Lung Infection 2 | Pulmonology |
Cure - Lung Infection 3 | Pulmonology |
Cure - Tissue Infection | Dermatology |
Cure - Tissue Infection 2 | Dermatology |
Cure - Tissue Infection 3 | Dermatology |
Cure - Brain Injury | Neuroptimization |
Cure - Brain Injury 2 | Neuroptimization |
Cure - Brain Injury 3 | Neuroptimization |
Cure - Burns | Dermatology |
Cure - Burns 2 | Dermatology |
Cure - Burns 3 | Dermatology |
Cure - Concussion | Neuroptimization |
Cure - Concussion 2 | Neuroptimization |
Cure - Concussion 3 | Neuroptimization |
Cure - Contusions | Traumatology |
Cure - Contusions 2 | Traumatology |
Cure - Contusions 3 | Traumatology |
Cure - Dislocated Limb | Kinesiology |
Cure - Dislocated Limb 2 | Kinesiology |
Cure - Dislocated Limb 3 | Kinesiology |
Cure - Fractured Limb | Osteology |
Cure - Fractured Limb 2 | Osteology |
Cure - Fractured Limb 3 | Osteology |
Cure - Fractured Skull | Osteology |
Cure - Fractured Skull 2 | Osteology |
Cure - Fractured Skull 3 | Osteology |
Cure - Frostbite | Dermatology |
Cure - Frostbite 2 | Dermatology |
Cure - Frostbite 3 | Dermatology |
Cure - Heatstroke | Thermoregulation |
Cure - Heatstroke 2 | Thermoregulation |
Cure - Heatstroke 3 | Thermoregulation |
Cure - Hernia | Gastroenterology |
Cure - Hernia 2 | Gastroenterology |
Cure - Hernia 3 | Gastroenterology |
Cure - Hypothermia | Thermoregulation |
Cure - Hypothermia 2 | Thermoregulation |
Cure - Hypothermia 3 | Thermoregulation |
Cure - Lacerations | Traumatology |
Cure - Lacerations 2 | Traumatology |
Cure - Lacerations 3 | Traumatology |
Cure - Lung Damage | Pulmonology |
Cure - Lung Damage 2 | Pulmonology |
Cure - Lung Damage 3 | Pulmonology |
Cure - Poisoning | Toxicology |
Cure - Poisoning 2 | Toxicology |
Cure - Poisoning 3 | Toxicology |
Cure - Puncture Wounds | Traumatology |
Cure - Puncture Wounds 2 | Traumatology |
Cure - Puncture Wounds 3 | Traumatology |
Cure - Radiation Poisoning | Radiobiology |
Cure - Radiation Poisoning 2 | Radiobiology |
Cure - Radiation Poisoning 3 | Radiobiology |
Cure - Sprain | Kinesiology |
Cure - Sprain 2 | Kinesiology |
Cure - Sprain 3 | Kinesiology |
Cure - Torn Muscle | Kinesiology |
Cure - Torn Muscle 2 | Kinesiology |
Cure - Torn Muscle 3 | Kinesiology |



# Item ideas from game

Molecular extractor