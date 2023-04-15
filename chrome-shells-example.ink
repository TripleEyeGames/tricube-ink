// game data

CONST number_of_faces = 6
LIST challengeDice = 
    d1 = 10, d1_1, d1_2, d1_3, d1_4, d1_5, d1_6,
    d2 = 20, d2_1, d2_2, d2_3, d2_4, d2_5, d2_6,
    d3 = 30, d3_1, d3_2, d3_3, d3_4, d3_5, d3_6
LIST challengeResolution = criticalFailure, failure, success, exceptionalSuccess

// character data

LIST characterTrait = agile, brawny, crafty
LIST characterConcept = samurai, hustler, thief, hacker, techie, wheelperson, saboteur
LIST characterPerk = cyberarm, boosted_reflexes, smartgun, custom_cyberdeck, microdrones, full_spectrum_vision, retractable_claws
LIST characterQuirk = inquisitive, cynical, obnoxious, foolhardy, brooding, callous, gloryhound

// gameplay variance

VAR characterKarma = 3
VAR characterResolve = 3
VAR challengeEffort = 0


//-> unitTests
-> characterCreation

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

=== function getRollResolutionRecursive(which_dice, difficulty_level_to_check)
    
    // if the value is not set, there's no resolution possible
    { challengeDice !? which_dice:
        ~return ()
    }
    
    // if we've passed the size of the dice w/o finding a match, it's a failure
    { difficulty_level_to_check > number_of_faces:
        ~ return challengeResolution.failure
    }
    
    {
        // if the value is 1, it's a potential critical failure
        - challengeDice ? challengeDice(LIST_VALUE(which_dice) + 1):
            ~ return challengeResolution.criticalFailure
            
        // if the value is set for the checked difficulty level, it's a success
        - challengeDice ? challengeDice(LIST_VALUE(which_dice) + difficulty_level_to_check):
            ~ return challengeResolution.success
        
        // if the value is not 1 and not set for the checked difficulty level, we need to proceed upwards
        - else:
            ~ return getRollResolutionRecursive(which_dice, difficulty_level_to_check + 1)
    }

=== function checkRollResults(difficulty)
    ~ temp combined_roll_results = ()
    ~ combined_roll_results = getRollResolutionRecursive(d1, difficulty) + getRollResolutionRecursive(d2, difficulty) + getRollResolutionRecursive(d3, difficulty)
    
    { 
        // if we have only critical failures, then it is a critical failure
        - combined_roll_results == challengeResolution.criticalFailure:
            ~ return challengeResolution.criticalFailure

        // if we have no successes, then it is a failure
        - combined_roll_results !? (challengeResolution.success):
            ~ return challengeResolution.failure
    }
    
    // count successes
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
    ~ return checkRollResults(difficulty)

=== function useKarma()
    {
    - characterKarma > 0:
        ~ characterKarma--
        ~ return true
    - else:
        ~ return false
    }

=== function loseResolve(resolution)
    {
    - challengeResolution == failure && characterResolve > 1:
        ~ characterResolve--
        ~ return true
    - challengeResolution == criticalFailure && characterResolve > 2:
        ~ characterResolve--
        ~ characterResolve--
        ~ return true
    - else:
        ~ return false
    }

=== function recoverKarma()
    ~ characterKarma++
    ~ return

=== function recoverResolve()
    ~ characterResolve++
    ~ return

=== challengeCheck (target_difficulty, applicable_trait, applicable_concepts, relevant_perks, relevant_quirks, -> goto_success, -> goto_failure)

    ~ temp check_result = challengeResolution()
    {
        - applicable_trait == characterTrait:
            ~ check_result = rollDice(3, target_difficulty)
        - else:
            ~ check_result = rollDice(2, target_difficulty)
    }
    
    {check_result} {challengeDice}

    { check_result:
        - challengeResolution.criticalFailure:
            -> goto_failure
        - challengeResolution.failure:
            -> goto_failure
        - challengeResolution.success:
            -> goto_success
        - challengeResolution.exceptionalSuccess:
            -> goto_success
    }


=== unitTests ===
    // which test suite do you want to run?
    -> checkRollResultsTests

    = getRollResolutionRecursiveTests
    // crit fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1)
    getRollResolutionRecursive - Critical Failure - 1 die ({challengeDice}) vs 5: {getRollResolutionRecursive(d1, 5) != criticalFailure:<b>!!!</b>|✔}
    
    // fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_2)
    getRollResolutionRecursive - Failure - 1 die ({challengeDice}) vs 3: {getRollResolutionRecursive(d1, 3) != failure:<b>!!!</b>|✔}
    
    // fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_5)
    getRollResolutionRecursive - Failure - 1 die ({challengeDice}) vs 6: {getRollResolutionRecursive(d1, 6) != failure:<b>!!!</b>|✔}
    
    // success
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_2)
    getRollResolutionRecursive - Success - 1 die ({challengeDice}) vs 2: {getRollResolutionRecursive(d1, 2) != success:<b>!!!</b>|✔}
    
    // success
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_6)
    getRollResolutionRecursive - Success - 1 die ({challengeDice}) vs 6: {getRollResolutionRecursive(d1, 6) != success:<b>!!!</b>|✔}
    

    -> END

    = checkRollResultsTests
    // crit fail - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1)
    checkRollResults - Critical Failure - 1 die ({challengeDice}) vs 5: {checkRollResults(5) != criticalFailure:<b>!!!</b>|✔}
    
    // crit fail - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_1)
    checkRollResults - Critical Failure - 2 die ({challengeDice}) vs 5: {checkRollResults(5) != criticalFailure:<b>!!!</b>|✔}
    
    // crit fail - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_1, d3, d3_1)
    checkRollResults - Critical Failure - 3 die ({challengeDice}) vs 5: {checkRollResults(5) != criticalFailure:<b>!!!</b>|✔}
    
    // fail - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3)
    checkRollResults - Failure - 1 die ({challengeDice}) vs 5: {checkRollResults(5) != failure:<b>!!!</b>|✔}
    
    // fail - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3, d2, d2_4)
    checkRollResults - Failure - 2 die ({challengeDice}) vs 5: {checkRollResults(5) != failure:<b>!!!</b>|✔}
    
    // fail - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_2, d3, d3_3)
    checkRollResults - Failure - 3 die ({challengeDice}) vs 5: {checkRollResults(5) != failure:<b>!!!</b>|✔}
    
    // success - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_5)
    checkRollResults - Success - 1 die ({challengeDice}) vs 5: {checkRollResults(5) != success:<b>!!!</b>|✔}
    
    // success - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3, d2, d2_6)
    checkRollResults - Success - 2 die ({challengeDice}) vs 5: {checkRollResults(5) != success:<b>!!!</b>|✔}
    
    // success - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_2, d3, d3_6)
    checkRollResults - Success - 3 die ({challengeDice}) vs 5: {checkRollResults(5) != success:<b>!!!</b>|✔}
    
    // exceptional success - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_6, d2, d2_6)
    checkRollResults - Exceptional Success - 2 die ({challengeDice}) vs 5: {checkRollResults(5) != exceptionalSuccess:<b>!!!</b>|✔}
    
    // exceptional success - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_5, d3, d3_6)
    checkRollResults - Exceptional Success - 3 die ({challengeDice}) vs 5: {checkRollResults(5) != exceptionalSuccess:<b>!!!</b>|✔}
    
    -> END

    = rollDiceTests
    
    // 1 die
    <tt>rollDice - 1 die vs 2: {rollDice(1, 2)} ({challengeDice})
    <tt>...................... {rollDice(1, 2)} ({challengeDice})
    <tt>...................... {rollDice(1, 2)} ({challengeDice})
    <tt>rollDice - 1 die vs 3: {rollDice(1, 3)} ({challengeDice})
    <tt>...................... {rollDice(1, 3)} ({challengeDice})
    <tt>...................... {rollDice(1, 3)} ({challengeDice})
    <tt>rollDice - 1 die vs 4: {rollDice(1, 4)} ({challengeDice})
    <tt>...................... {rollDice(1, 4)} ({challengeDice})
    <tt>...................... {rollDice(1, 4)} ({challengeDice})
    <tt>rollDice - 1 die vs 5: {rollDice(1, 5)} ({challengeDice})
    <tt>...................... {rollDice(1, 5)} ({challengeDice})
    <tt>...................... {rollDice(1, 5)} ({challengeDice})
    <tt>rollDice - 1 die vs 6: {rollDice(1, 6)} ({challengeDice})
    <tt>...................... {rollDice(1, 6)} ({challengeDice})
    <tt>...................... {rollDice(1, 6)} ({challengeDice})
    
    // 2 die
    <tt>rollDice - 2 die vs 2: {rollDice(2, 2)} ({challengeDice})
    <tt>...................... {rollDice(2, 2)} ({challengeDice})
    <tt>...................... {rollDice(2, 2)} ({challengeDice})
    <tt>rollDice - 2 die vs 3: {rollDice(2, 3)} ({challengeDice})
    <tt>...................... {rollDice(2, 3)} ({challengeDice})
    <tt>...................... {rollDice(2, 3)} ({challengeDice})
    <tt>rollDice - 2 die vs 4: {rollDice(2, 4)} ({challengeDice})
    <tt>...................... {rollDice(2, 4)} ({challengeDice})
    <tt>...................... {rollDice(2, 4)} ({challengeDice})
    <tt>rollDice - 2 die vs 5: {rollDice(2, 5)} ({challengeDice})
    <tt>...................... {rollDice(2, 5)} ({challengeDice})
    <tt>...................... {rollDice(2, 5)} ({challengeDice})
    <tt>rollDice - 2 die vs 6: {rollDice(2, 6)} ({challengeDice})
    <tt>...................... {rollDice(2, 6)} ({challengeDice})
    <tt>...................... {rollDice(2, 6)} ({challengeDice})
    
    // 3 die
    <tt>rollDice - 3 die vs 2: {rollDice(3, 2)} ({challengeDice})
    <tt>...................... {rollDice(3, 2)} ({challengeDice})
    <tt>...................... {rollDice(3, 2)} ({challengeDice})
    <tt>rollDice - 3 die vs 3: {rollDice(3, 3)} ({challengeDice})
    <tt>...................... {rollDice(3, 3)} ({challengeDice})
    <tt>...................... {rollDice(3, 3)} ({challengeDice})
    <tt>rollDice - 3 die vs 4: {rollDice(3, 4)} ({challengeDice})
    <tt>...................... {rollDice(3, 4)} ({challengeDice})
    <tt>...................... {rollDice(3, 4)} ({challengeDice})
    <tt>rollDice - 3 die vs 5: {rollDice(3, 5)} ({challengeDice})
    <tt>...................... {rollDice(3, 5)} ({challengeDice})
    <tt>...................... {rollDice(3, 5)} ({challengeDice})
    <tt>rollDice - 3 die vs 6: {rollDice(3, 6)} ({challengeDice})
    <tt>...................... {rollDice(3, 6)} ({challengeDice})
    <tt>...................... {rollDice(3, 6)} ({challengeDice})
    
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
You have been hired to break into a “Haven Hosting” facility and steal a magical HAVEN figurine from the premises.
There are dozens of these locations scattered around the world, each built upon areas of natural magic to strengthen their enchantments and wards. Ostensibly, the facilities are designed to host and protect Haven’s computer servers—but top tier customers are also offered a safe deposit box service called the “Vault.”

-> attemptEntry

= attemptEntry
You can approach the facility in a variety of ways. Which do you want to try?
    * [Stealth]
        -> challengeCheck (6, characterTrait.agile, (samurai, thief, saboteur), (), (), -> sneak_in_success, -> attemptEntry )
        
    * [Brute Force]
        -> welcome_inside
    * [Deception]
        -> welcome_inside
        
= sneak_in_success
    -> welcome_inside
= welcome_inside
    Welcome inside!
    -> END
