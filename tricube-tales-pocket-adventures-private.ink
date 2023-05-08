//********************************
//*                              *
//*        PRIVATE DATA          *
//*                              *
//* THESE ARE ALL REPRESENTATIVE *
//* OF CORE TRICUBE TALE SYSTEMS *
//*                              *
//********************************

// game data

CONST MAX_DICE = 3

LIST challengeDice = 
    d1 = 10, d1_1, d1_2, d1_3, d1_4, d1_5, d1_6,
    d2 = 20, d2_1, d2_2, d2_3, d2_4, d2_5, d2_6,
    d3 = 30, d3_1, d3_2, d3_3, d3_4, d3_5, d3_6

LIST challengeType = safe, dangerous
LIST challengeDifficulty = easy = 4, standard = 5, hard = 6
LIST challengeResolution = criticalFailure, failure, success, exceptionalSuccess

VAR challengeQuirkActive = false

CONST MAX_EFFORT_TRIES = 20
VAR challengeEffortProgress = 0

// character data

CONST MAX_KARMA = 3
VAR characterKarma = MAX_KARMA

CONST MAX_RESOLVE = 3
VAR characterResolve = MAX_RESOLVE

// engine settings

VAR showRollResults = false
VAR showDebugMessages = false

//*******************************
//*                             *
//*  PRIVATE HELPER FUNCTIONS   *
//*                             *
//*******************************

=== function getRollResolutionRecursive(which_dice, difficulty_level_to_check)
    
    {showDebugMessages:getRollResolutionRecursive({which_dice}, {difficulty_level_to_check} ({LIST_VALUE(difficulty_level_to_check)}))}
    
    // if the value is not set, there's no resolution possible
    { challengeDice !? which_dice:
        ~return ()
    }
    
    // if we've passed the size of the dice w/o finding a match, it's a failure
    { not difficulty_level_to_check:
        ~ return challengeResolution.failure
    }
    
    {
        // if the value is 1, it's a critical failure
        - challengeDice ? challengeDice(LIST_VALUE(which_dice) + 1):
            ~ return challengeResolution.criticalFailure
            
        // if the value is set for the checked difficulty level, it's a success
        - challengeDice ? challengeDice(LIST_VALUE(which_dice) + LIST_VALUE(difficulty_level_to_check)):
            ~ return challengeResolution.success
        
        // if the value is not 1 and not set for the checked difficulty level, we need to proceed upwards
        - else:
            ~ return getRollResolutionRecursive(which_dice, challengeDifficulty(LIST_VALUE(difficulty_level_to_check) + 1))
    }

=== function countSuccesses(difficulty)
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
    
    ~ return number_of_successes

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
    ~ temp number_of_successes = countSuccesses(difficulty)

    // check for exceptional success
    { number_of_successes:
    - 1:
        ~ return challengeResolution.success
    - else:
        ~ return challengeResolution.exceptionalSuccess
    }

=== function rollRecursive(number_of_dice)

    {
    - number_of_dice > MAX_DICE:
        !!! ERROR: The storyteller is trying to roll {number_of_dice} when there are only {MAX_DICE} dice max.
    - number_of_dice > 0:
        {showDebugMessages:rollRecursive - {LIST_MAX(LIST_ALL(challengeDifficulty))}({LIST_VALUE(LIST_MAX(LIST_ALL(challengeDifficulty)))})}
        ~ temp rolled_value = RANDOM(1, LIST_VALUE(LIST_MAX(LIST_ALL(challengeDifficulty))))

        ~ temp dice_offset = (number_of_dice * 10) + rolled_value
        ~ challengeDice += challengeDice(dice_offset)

        ~ challengeDice += challengeDice(number_of_dice * 10)
        ~ rollRecursive(number_of_dice - 1)
    // number_of_dice <= 0: recursion complete
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

=== chooseQuirkPayout()

    {
        // short circuit if a quirk is not currently active
        - not challengeQuirkActive:
            ->->
    }
    
    // turning off the flag, regardless of what happens next
    ~ challengeQuirkActive = false

    {
        // short circuit if the character already has max karma/resolve
        - characterKarma >= MAX_KARMA and characterResolve >= MAX_RESOLVE:
            ->->
        
        // short circuit if the challenge was a failure, and the character already has max karma
        // (the implication is that, if we make it here, the earlier check ( characterResolve >= MAX_RESOLVE ) was false
        - (failure, criticalFailure) ? challengeResolution and characterKarma >= MAX_KARMA:
            ->->
    }

    What do you want in return for applying your quirk?
        + {characterKarma < MAX_KARMA} [Recover 1 karma.]
            ~ recoverKarma()
            ->->
        + {(success, exceptionalSuccess) ? challengeResolution and characterResolve < MAX_RESOLVE} [Recover 1 resolve.]
            ~ recoverResolve()
            ->->
        + Nothing.
            ->->


=== offerToApplyQuirkToChallengeRoll(applicable_quirks)

    {
        // short circuit if the challenge cannot be made more difficult
        - not (challengeDifficulty + 1):
            ->->

        // short circuit if the character already has max karma/resolve
        - characterKarma >= MAX_KARMA && characterResolve >= MAX_RESOLVE:
            ->->
    }

    // if you have an applicable quirk and less than max karma, offer to regain some karma
    {
    - LIST_COUNT(applicable_quirks) > 0 and applicable_quirks ? characterQuirk:
        You can try to recover some karma/resolve by being {getCharacterQuirkDescription(characterQuirk)} to increase the challenge difficulty (from {challengeDifficulty} to {challengeDifficulty + 1}).
            + [Let my {getCharacterQuirkDescription(characterQuirk)} overcome me!]
                ~ challengeDifficulty++
                ~ challengeQuirkActive = true
                ->->
            + [Continue as-is.]
                ->->
            -
                ->->
    }

=== challengeRollSetup(target_difficulty, applicable_quirks)

    // setting base values for internal checks
    ~ challengeResolution = ()
    ~ challengeQuirkActive = false

    ~ challengeDifficulty = target_difficulty

    // difficulty can be increased (if the player opts-in)
    -> offerToApplyQuirkToChallengeRoll(applicable_quirks) ->
    
    ->->

=== offerToUseKarmaInChallengeRoll()

    - You've failed, but a little karma goes a long way.
        + [Use your {getCharacterPerkDescription(characterPerk)} (and 1 karma) to succeed.]
            {
                - useKarma():
                    ~ challengeResolution = success
                    {showDebugMessages:<> - {challengeDice} - Success!}
                    ->->
                - else:
                    {showDebugMessages:<> - {challengeDice} - Failure...}
                    ->->
            }
        + [Accept failure.]
            {showDebugMessages:<> - {challengeDice} - Failure...}
            ->->
    ->->

=== doOneChallengeRoll(applicable_trait, applicable_concepts, applicable_perks)

    ~temp dice_to_roll = 1
    {
        - applicable_trait == characterTrait:
            ~ dice_to_roll = 3
        - applicable_concepts ? characterConcept:
            ~ dice_to_roll = 2
    }

    // DO THE CHECK
    ~ challengeResolution = rollDice(dice_to_roll, challengeDifficulty)
    {showDebugMessages:<> - {challengeDice} - {challengeResolution}}

    -> chooseQuirkPayout() ->
    
    { challengeResolution:
        - criticalFailure:
            {showRollResults:<> Critical Failure...}
            ->->

        - failure:
            // if you have an applicable perk, and it would result in turning this failure to a success...
            {
            - characterKarma > 0 and applicable_perks ? characterPerk and (success, exceptionalSuccess) ? checkRollResults(challengeDifficulty - 1):
                -> offerToUseKarmaInChallengeRoll ->
            - else:
                {showRollResults:<> Failure...}
                ->->
            }

        - success:
            {showRollResults:<> Success!}
            ->->

        - exceptionalSuccess:
            {showRollResults:<> Exceptional Success!}
            ->->
    }
    
    ->->

=== challengeCheckWithEffortRecursive(recursion_depth, required_effort, maximum_tries, target_difficulty, applicable_trait, applicable_concepts, applicable_perks, applicable_quirks)

    {
        // we're done!
        - challengeEffortProgress >= required_effort:
            ->->
        
        // short circuit recursion if there's a limit set
        - maximum_tries > 0 && recursion_depth > maximum_tries:
            ->->
            
        // short circuit if we reach a maximum limit
        - recursion_depth >= MAX_EFFORT_TRIES:
            ->->
    }
    
    // target_difficulty has been converted to challengeDifficulty in setup; nothing else should use target_difficulty
    -> challengeRollSetup(target_difficulty, ()) ->

    {showDebugMessages: {challengeEffortProgress} progress vs {required_effort} effort}

    // do the check
    -> doOneChallengeRoll(applicable_trait, applicable_concepts, applicable_perks) ->
    
    // advance our counter on successes
    { challengeResolution:
    - success:
        ~ challengeEffortProgress++

    - exceptionalSuccess:
        ~ challengeEffortProgress = challengeEffortProgress + countSuccesses(challengeDifficulty)
    }
    
    // continue recursive loop
    -> challengeCheckWithEffortRecursive(1 + recursion_depth, required_effort, maximum_tries, target_difficulty, applicable_trait, applicable_concepts, applicable_perks, applicable_quirks) ->

    ->->
