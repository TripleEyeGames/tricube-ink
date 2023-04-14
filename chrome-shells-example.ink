
// character data

LIST characterTrait = agile, brawny, crafty
LIST characterConcept = samurai, hustler, thief, hacker, techie, wheelperson, saboteur
LIST characterPerk = cyberarm, boosted_reflexes, smartgun, custom_cyberdeck, microdrones, full_spectrum_vision, retractable_claws
LIST characterQuirk = inquisitive, cynical, obnoxious, foolhardy, brooding, callous, gloryhound

// gameplay data
VAR number_of_faces = 6
LIST challengeDice = 
    d1 = 10, d1_1, d1_2, d1_3, d1_4, d1_5, d1_6,
    d2 = 20, d2_1, d2_2, d2_3, d2_4, d2_5, d2_6,
    d3 = 30, d3_1, d3_2, d3_3, d3_4, d3_5, d3_6

LIST challengeResolution = criticalFailure, failure, success, exceptionalSuccess

-> unitTests
//-> characterCreation

/*****************************************
 *                                       *
 *  CHARACTER CREATION HELPER FUNCTIONS  *
 *                                       *
 *****************************************/

=== function makeRandomCharacter()
    ~ characterTrait = LIST_RANDOM(LIST_ALL(characterTrait))
    ~ characterConcept = LIST_RANDOM(LIST_ALL(characterConcept))
    ~ characterPerk = LIST_RANDOM(LIST_ALL(characterPerk))
    ~ characterQuirk = LIST_RANDOM(LIST_ALL(characterQuirk))

    ~ return

=== function getCharacterTraitDescription(player_trait)
    { player_trait:
    - agile:
        ~ return "Agile"
    - brawny:
        ~ return "Brawny"
    - crafty:
        ~ return "Crafty"
    - else:
        ~ return "!! Unknown Traits !!"
    }

=== function getCharacterConceptDescription(player_concept)
    { player_concept:
    - samurai:
        ~ return "Street Samurai"
    - hustler:
        ~ return "Hustler"
    - thief:
        ~ return "Thief"
    - hacker:
        ~ return "Hacker"
    - techie:
        ~ return "Techie"
    - wheelperson:
        ~ return "Getaway Driver"
    - saboteur:
        ~ return "Saboteur"
    - else:
        ~ return "!! Unknown Concepts !!"
    }

=== function getCharacterPerkDescription(player_perk)
    { player_perk:
    - cyberarm:
        ~ return "a Cybernetic Arm"
    - boosted_reflexes:
        ~ return "Boosted Reflexes"
    - smartgun:
        ~ return "a Smartgun"
    - custom_cyberdeck:
        ~ return "a Custom Cyberdeck"
    - microdrones:
        ~ return "Micro-Drones"
    - full_spectrum_vision:
        ~ return "Full-Spectrum Vision"
    - retractable_claws:
        ~ return "Retractable Claws"
    - else:
        ~ return "!! Unknown Perks !!"
    }

=== function getCharacterQuirkDescription(player_quirk)
    { player_quirk:
    - inquisitive:
        ~ return "Inquisitive"
    - cynical:
        ~ return "Cynical"
    - obnoxious:
        ~ return "Obnoxious"
    - foolhardy:
        ~ return "Foolhardy"
    - brooding:
        ~ return "Brooding"
    - callous:
        ~ return "Callous"
    - gloryhound:
        ~ return "Narcissistic"
    - else:
        ~ return "!! Unknown Quirks !!"
    }

=== function printCharacterDescription()
    You are a{characterTrait == agile :n} { getCharacterTraitDescription(characterTrait) } {getCharacterConceptDescription(characterConcept)} with {getCharacterPerkDescription(characterPerk)}. {~Your friends agree|Your enemies all say|You've been told|Some say} your {getCharacterQuirkDescription(characterQuirk)} {~approach|personality|style} can {~make working with you difficult|be grating|lead to surprises}.
    
    ~ return
  

//*******************************
//*                             *
//*  GAMEPLAY HELPER FUNCTIONS  *
//*                             *
//*******************************

=== function getRollResolutionRecursive(which_dice, difficulty)
    
    // if the value is 1, it's a potential critical failure
    { challengeDice ? challengeDice(LIST_VALUE(which_dice) + 1):
        ~ return challengeResolution.criticalFailure
    }
    
    // if we've passed the size of the dice w/o finding a match, it's a failure
    { difficulty > number_of_faces:
        ~ return challengeResolution.failure
    }
    
    { challengeDice ? challengeDice(LIST_VALUE(which_dice) + difficulty):
        ~ return challengeResolution.success
    - else:
        ~ return getRollResolutionRecursive(which_dice, difficulty + 1)
    }


=== function checkRollResults(number_of_dice, difficulty)
    // check for critical failure
    ~ temp roll_results = ()
    ~ roll_results = challengeResolution()
    
    ~ temp crit_fail_counter = 0
    { challengeDice ? (d1, d1_1):
        ~ crit_fail_counter++
    }
    { challengeDice ? (d2, d2_1):
        ~ crit_fail_counter++
    }
    { challengeDice ? (d3, d3_1):
        ~ crit_fail_counter++
    }
    
    { number_of_dice == crit_fail_counter:
        ~ return challengeResolution.criticalFailure
    }
    
    // check for success
    ~ temp number_of_successes = 0
    { challengeDice ? d1 && getRollResolutionRecursive(d1, difficulty) == challengeResolution.success:
        ~ number_of_successes++
    }
    { challengeDice ? d2 && getRollResolutionRecursive(d2, difficulty) == challengeResolution.success:
        ~ number_of_successes++
    }
    { challengeDice ? d3 && getRollResolutionRecursive(d3, difficulty) == challengeResolution.success:
        ~ number_of_successes++
    }

    // check for exceptional success
    { number_of_successes:
    - 0:
        ~ return challengeResolution.failure
    - 1:
        ~ return challengeResolution.success
    - else:
        ~ return challengeResolution.exceptionalSuccess
    }


=== function rollRecursive(number_of_dice)
    { number_of_dice > 0:
        ~ temp rolled_value = RANDOM(1, number_of_faces)
        
        ~ temp dice_offset = (number_of_dice * 10) + rolled_value
        ~ challengeDice += challengeDice(dice_offset)

        ~ challengeDice += challengeDice(number_of_dice * 10)
        ~ rollRecursive(number_of_dice - 1) 
    }

    ~ return


=== function rollDice(number_of_dice, difficulty)
    ~ challengeDice = ()
    ~ rollRecursive(number_of_dice)
    ~ return checkRollResults(number_of_dice, difficulty)


=== unitTests ===
    = checkRollResultsTests
    // crit fail - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1)
    checkRollResults - Critical Failure - 1 die ({challengeDice}) vs 5: {checkRollResults(1, 5)}
    
    // crit fail - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_1)
    checkRollResults - Critical Failure - 2 die ({challengeDice}) vs 5: {checkRollResults(2, 5)}
    
    // crit fail - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_1, d3, d3_1)
    checkRollResults - Critical Failure - 3 die ({challengeDice}) vs 5: {checkRollResults(3, 5)}
    
    // fail - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3)
    checkRollResults - Failure - 1 die ({challengeDice}) vs 5: {checkRollResults(1, 5)}
    
    // fail - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3, d2, d2_4)
    checkRollResults - Failure - 2 die ({challengeDice}) vs 5: {checkRollResults(2, 5)}
    
    // fail - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_2, d3, d3_3)
    checkRollResults - Failure - 3 die ({challengeDice}) vs 5: {checkRollResults(3, 5)}
    
    // success - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_5)
    checkRollResults - Success - 1 die ({challengeDice}) vs 5: {checkRollResults(1, 5)}
    
    // success - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3, d2, d2_6)
    checkRollResults - Success - 2 die ({challengeDice}) vs 5: {checkRollResults(2, 5)}
    
    // success - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_2, d3, d3_6)
    checkRollResults - Success - 3 die ({challengeDice}) vs 5: {checkRollResults(3, 5)}
    
    // exceptional success - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_5)
    checkRollResults - (Exceptional) Success - 1 die ({challengeDice}) vs 5: {checkRollResults(1, 5)}
    
    // exceptional success - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_6, d2, d2_6)
    checkRollResults - Exceptional Success - 2 die ({challengeDice}) vs 5: {checkRollResults(2, 5)}
    
    // exceptional success - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_5, d3, d3_6)
    checkRollResults - Exceptional Success - 3 die ({challengeDice}) vs 5: {checkRollResults(3, 5)}
    
-> END


=== characterCreation ===
Welcome to the Chrome Shells & Neon Streets demo, made in Inky!

We should put the one-pager introduction, if we share this with other people. I'm cutting corners, though!

    * [Randomly generate my character.]
        -> doRandomGeneration
    * [Allow me to create my character, please.]
        -> doCharacterConfiguration


= doRandomGeneration
~ makeRandomCharacter()
~ printCharacterDescription()

Is that correct?
    * * [Yes]
        -> startTheJob
    + + [No]
        -> doRandomGeneration

= doCharacterConfiguration
Okay, let's {LIST_COUNT(characterTrait) == 0 : begin | try again}!
-> setcharacterTrait

= setcharacterTrait
Please pick your character's main trait:
+ [Agile]
    ~ characterTrait = agile
    -> setcharacterConcept
+ Brawny
    ~ characterTrait = brawny
    -> setcharacterConcept
+ Crafty
    ~ characterTrait = crafty
    -> setcharacterConcept

= setcharacterConcept
Now, please select your character's core concept:
+ [Street Samurai]
    ~ characterConcept = samurai
    -> setcharacterPerk
+ [Hustler]
    ~ characterConcept = hustler
    -> setcharacterPerk
+ [Thief]
    ~ characterConcept = thief
    -> setcharacterPerk
+ [Hacker]
    ~ characterConcept = hacker
    -> setcharacterPerk
+ [Techie]
    ~ characterConcept = techie
    -> setcharacterPerk
+ [Getaway Driver]
    ~ characterConcept = wheelperson
    -> setcharacterPerk
+ [Saboteur]
    ~ characterConcept = saboteur
    -> setcharacterPerk

= setcharacterPerk
What special perk does your character have?
+ [a Cybernetic Arm]
    ~ characterPerk = cyberarm
    -> setcharacterQuirk
+ [Boosted Reflexes]
    ~ characterPerk = boosted_reflexes
    -> setcharacterQuirk
+ [a Smartgun]
    ~ characterPerk = smartgun
    -> setcharacterQuirk
+ [a Custom Cyberdeck]
    ~ characterPerk = custom_cyberdeck
    -> setcharacterQuirk
+ [Micro-Drones]
    ~ characterPerk = microdrones
    -> setcharacterQuirk
+ [Full-Spectrum Vision]
    ~ characterPerk = full_spectrum_vision
    -> setcharacterQuirk
+ [Retractable Claws]
    ~ characterPerk = retractable_claws
    -> setcharacterQuirk

= setcharacterQuirk
Finally, what quirk does your character have?
+ [Inquisitive]
    ~ characterQuirk = inquisitive
    -> verifyPlayerChoices
+ [Cynical]
    ~ characterQuirk = cynical
    -> verifyPlayerChoices
+ [Obnoxious]
    ~ characterQuirk = obnoxious
    -> verifyPlayerChoices
+ [Foolhardy]
    ~ characterQuirk = foolhardy
    -> verifyPlayerChoices
+ [Brooding]
    ~ characterQuirk = brooding
    -> verifyPlayerChoices
+ [Callous]
    ~ characterQuirk = callous
    -> verifyPlayerChoices
+ [Narcissistic]
    ~ characterQuirk = gloryhound
    -> verifyPlayerChoices

= verifyPlayerChoices
If I've got this right... <>
~ printCharacterDescription()

Is that correct?
    * * [Yes]
        -> startTheJob
    + + [No]
        -> doCharacterConfiguration

=== startTheJob ===
- They lived happily ever after.
    -> END
