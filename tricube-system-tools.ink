// game data

CONST MAX_DIFFICULTY = 6
CONST MAX_DICE = 3
LIST challengeDice = 
    d1 = 10, d1_1, d1_2, d1_3, d1_4, d1_5, d1_6,
    d2 = 20, d2_1, d2_2, d2_3, d2_4, d2_5, d2_6,
    d3 = 30, d3_1, d3_2, d3_3, d3_4, d3_5, d3_6

LIST challengeType = safe, dangerous
LIST challengeResolution = criticalFailure, failure, success, exceptionalSuccess

VAR challengeDifficulty = 0
VAR challengeEffort = 0

// character data

CONST MAX_KARMA = 3
VAR characterKarma = MAX_KARMA

CONST MAX_RESOLVE = 3
VAR characterResolve = MAX_RESOLVE

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
    { difficulty_level_to_check > MAX_DIFFICULTY:
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

    {
    - number_of_dice > MAX_DICE:
        DEBUG: What are you doing? There's only {MAX_DICE} dice available.
    - number_of_dice > 0:
        ~ temp rolled_value = RANDOM(1, MAX_DIFFICULTY)
        
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

=== function loseResolve(challenge_type)

    {
    - challenge_type == challengeType.safe:
        {
        - characterResolve > 1:
            ~ characterResolve--
            ~ return true
        }
    - else:
        {
        - characterResolve  > 2:
            ~ characterResolve--
            ~ characterResolve--
            ~ return true
        }
    }

    ~ return false

=== function recoverKarma()

    {
    - characterKarma < MAX_KARMA:
        ~ characterKarma++
        ~ return true
    - else:
        ~ return false
    }

=== function recoverResolve()

    {
    - characterResolve < MAX_RESOLVE:
        ~ characterResolve++
        ~ return true
    - else:
        ~ return false
    }

=== offerToRecoverKarma(target_difficulty, applicable_quirks)

    // if you have an applicable quirk and less than max karma, offer to regain some karma
    {
    - target_difficulty < MAX_DIFFICULTY and applicable_quirks ? characterQuirk and characterKarma < MAX_KARMA:
        You can recover some karma by increasing the difficulty by 1 before the check.
        + Recover 1 karma (new difficulty: {target_difficulty + 1}).
            ~ recoverKarma()
            ~ challengeDifficulty++
            ->->
        + Continue as-is.
            ->->
    }

    ->->

=== challengeCheck (target_difficulty, applicable_trait, applicable_concepts, applicable_perks, applicable_quirks, -> goto_failure)

    ~ challengeDifficulty = target_difficulty
    
    -> offerToRecoverKarma(target_difficulty, applicable_quirks) ->
    
    ~ temp check_result = challengeResolution()
    {
        - applicable_trait == characterTrait:
            ~ check_result = rollDice(3, challengeDifficulty)
        - applicable_concepts ? characterConcept:
            ~ check_result = rollDice(2, challengeDifficulty)
        - else:
            ~ check_result = rollDice(1, challengeDifficulty)
    }
    
    DEBUG: {check_result} {challengeDice}

    { check_result:
        - challengeResolution.criticalFailure:
            ->-> goto_failure
        - challengeResolution.failure:
            // if you have an applicable perk, and it would result in turning this failure to a success...
            {
            - characterKarma > 0 and applicable_perks ? characterPerk and (success, exceptionalSuccess) ? checkRollResults(challengeDifficulty - 1):
                You've failed, but a little karma goes a long way.
                + Use your {getCharacterPerkDescription(characterPerk)} (and 1 karma) to succeed.
                    { useKarma(): ->-> }
                + Accept failure.
                    ->-> goto_failure
            ->-> goto_failure
            }
        - challengeResolution.success:
            ->->
        - challengeResolution.exceptionalSuccess:
            ->->
    }
    
