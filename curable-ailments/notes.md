# Curable Ailments

- [ ] Make Machine constructable
- [ ] Make vial constructable
- [ ] Make machine require first research project
- [ ] BUild out projects


Both cures and the machine have different levels
- level 1 cures lightest, level 4 cures all
- higher machine needs higher chemistry
- highest level machine needs special projects
- higher cures require higher medicine

; add brain injury (not working for prognosis)
player.addspell 002bdd18
; add panacea
player.additem 0029a859 10
;injector
player.additem 002f445a 10
player.getav AFFL_PrognosisAV_Infection_BrainInfection

Since can't see effect on spell, maybe make sure NO prognosis OTHER than excellent

Infection is spell ability: ENV_AFFL_Infection_BoneInfection_1
Include magic effect prognosis excedllent: 
ENV_AFFL_Prognosis_Infection_3_Excellent
ENV_AFFL_Prognosis_Injury_3_Excellent

Items -> Research Project -> Chem_Research_InnovativeSynthesis_01



## Research Projects

Name | Projects | Perks | Items
--- | --- | --- | ---
BioMechanics | | |
BioMechanics 2 | | |
BioMechanics 3 | | |
Neuroptimization | BioMechanics | | 
Neuroptimization 2 | Neuroptimization | |
Neuroptimization 3 | Neuroptimization 2 | |
Osteology | BioMechanics | | 
Osteology 2 | Osteology | |
Osteology 3 | Osteology 2 | |

## Constructable Objects

Result | Project | Items
--- | --- | --
Injector 1 | BioMechanics | Microscope01
Cure - Brain Infection | Neuroptimization |
Cure - Brain Infection 2 | Neuroptimization |
Cure - Brain Infection 3 | Neuroptimization |


## Ailments
Brain Injury - Injector, Snake Oil
Burns - Heal Gel, Heal Paste, Antibiotic Paste, Infused Bandages, Analgesic Poultice
Concussion - Injector, Snake Oil
Contusions - Bandages, Repairing Immobilizer, Infused Bandages, Analgesic Poultice
Dislocated Limb - Immobilizer, Repairing Immobilizer, Anchored Immobilizer
Fractured Limb - Immobilizer, Repairing Immobilizer, Anchored Immobilizer
Fractured Skull - Immobilizer, Repairing Immobilizer, Anchored Immobilizer
Frostbite - Heal Gel, Heal Paste, Antibiotic Paste, Infused Bandages, Analgesic Poultice
Heatstroke - Injector, Snake Oil
Hernia - Injector, Snake Oil
Hypothermia - Injector, Snake Oil
Infections - Antibiotics, Penicillin X, Antibiotic Paste, Antibiotic Cocktail, Analgesic Poultice
Lacerations - Bandages, Infused Bandages, Repairing Immobilizer, Analgesic Poultice
Lung Damage - Injector, Snake Oil
Poisoning - Injector, Snake Oil
Puncture Wounds - Bandages, Repairing Immobilizer, Infused Bandages, Analgesic Poultice
Radiation Poisoning - Injector, Snake Oil
Sprain - Immobilizer, Repairing Immobilizer, Anchored Immobilizer
Torn Muscle - Immobilizer, Repairing Immobilizer, Anchored Immobilizer



ENV_AFFL_Infection_BoneInfection_1
ENV_AFFL_Infection_BoneInfection_2
ENV_AFFL_Infection_BoneInfection_3
ENV_AFFL_Infection_BrainInfection_1
ENV_AFFL_Infection_BrainInfection_2
ENV_AFFL_Infection_BrainInfection_3
ENV_AFFL_Infection_IntestinalInfection_1
ENV_AFFL_Infection_IntestinalInfection_2
ENV_AFFL_Infection_IntestinalInfection_3
ENV_AFFL_Infection_LungInfection_1
ENV_AFFL_Infection_LungInfection_2
ENV_AFFL_Infection_LungInfection_3
ENV_AFFL_Infection_TissueInfection_1
ENV_AFFL_Infection_TissueInfection_2
ENV_AFFL_Infection_TissueInfection_3
ENV_AFFL_Injury_BrainInjury_1
ENV_AFFL_Injury_BrainInjury_2
ENV_AFFL_Injury_BrainInjury_3
ENV_AFFL_Injury_Burns_1
ENV_AFFL_Injury_Burns_2
ENV_AFFL_Injury_Burns_3
ENV_AFFL_Injury_Concussion_1
ENV_AFFL_Injury_Concussion_2
ENV_AFFL_Injury_Concussion_3
ENV_AFFL_Injury_Contusions_1
ENV_AFFL_Injury_Contusions_2
ENV_AFFL_Injury_Contusions_3
ENV_AFFL_Injury_DislocatedLimb_1
ENV_AFFL_Injury_DislocatedLimb_2
ENV_AFFL_Injury_DislocatedLimb_3
ENV_AFFL_Injury_FracturedLimb_1
ENV_AFFL_Injury_FracturedLimb_2
ENV_AFFL_Injury_FracturedLimb_3
ENV_AFFL_Injury_FracturedSkull_1
ENV_AFFL_Injury_FracturedSkull_2
ENV_AFFL_Injury_FracturedSkull_3
ENV_AFFL_Injury_Frostbite_1
ENV_AFFL_Injury_Frostbite_2
ENV_AFFL_Injury_Frostbite_3
ENV_AFFL_Injury_Heatstroke_1
ENV_AFFL_Injury_Heatstroke_2
ENV_AFFL_Injury_Heatstroke_3
ENV_AFFL_Injury_Hernia_1
ENV_AFFL_Injury_Hernia_2
ENV_AFFL_Injury_Hernia_3
ENV_AFFL_Injury_Hypothermia_1
ENV_AFFL_Injury_Hypothermia_2
ENV_AFFL_Injury_Hypothermia_3
ENV_AFFL_Injury_Lacerations_1
ENV_AFFL_Injury_Lacerations_2
ENV_AFFL_Injury_Lacerations_3
ENV_AFFL_Injury_LungDamage_1
ENV_AFFL_Injury_LungDamage_2
ENV_AFFL_Injury_LungDamage_3
ENV_AFFL_Injury_Poisoning_1
ENV_AFFL_Injury_Poisoning_2
ENV_AFFL_Injury_Poisoning_3
ENV_AFFL_Injury_PunctureWounds_1
ENV_AFFL_Injury_PunctureWounds_2
ENV_AFFL_Injury_PunctureWounds_3
ENV_AFFL_Injury_RadiationPoisoning_1
ENV_AFFL_Injury_RadiationPoisoning_2
ENV_AFFL_Injury_RadiationPoisoning_3
ENV_AFFL_Injury_Sprain_1
ENV_AFFL_Injury_Sprain_2
ENV_AFFL_Injury_Sprain_3
ENV_AFFL_Injury_TornMuscle_1
ENV_AFFL_Injury_TornMuscle_2
ENV_AFFL_Injury_TornMuscle_3