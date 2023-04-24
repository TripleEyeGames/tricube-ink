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

CONST MAX_EFFORT_TRIES = 30
VAR challengeEffortProgress = 0

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

=== challengeSetup(target_difficulty, applicable_quirks)

    // setting base values for internal checks
    ~ challengeResolution = ()

    ~ challengeDifficulty = target_difficulty
    
    // difficulty can be increased (if the player opts-in)
    -> offerToRecoverKarma(applicable_quirks) ->

    ->->

=== offerToRecoverKarma(applicable_quirks)

    {
        // short circuit if the challenge cannot be made more difficult
        - challengeDifficulty >= MAX_DIFFICULTY:
            ->->
            
        // short circuit if the character already has max karma
        - characterKarma >= MAX_KARMA:
            ->->
    }

    // if you have an applicable quirk and less than max karma, offer to regain some karma
    {
     - LIST_COUNT(applicable_quirks) > 0 and applicable_quirks ? characterQuirk:
        You can recover some karma by being {characterQuirk} to increase the challenge difficulty by 1.
        + Recover 1 karma (new difficulty: {challengeDifficulty + 1}).
            ~ recoverKarma()
            ~ challengeDifficulty++
            ->->
        + Continue as-is.
            ->->
    }

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
    
    // DEBUG: {challengeResolution}
    
    { challengeResolution:
        - criticalFailure:
            <> Critical Failure...
            ->->

        - failure:
            // if you have an applicable perk, and it would result in turning this failure to a success...
            {
            - characterKarma > 0 and applicable_perks ? characterPerk and (success, exceptionalSuccess) ? checkRollResults(challengeDifficulty - 1):
                You've failed, but a little karma goes a long way.
                + [Use your {getCharacterPerkDescription(characterPerk)} (and 1 karma) to succeed.]
                    {
                        - useKarma():
                            ~ challengeResolution = success
                            <> Success!
                            ->->
                        - else:
                            <> Failure...
                            ->->
                    }
                + [Accept failure.]
                    <> Failure...
                    ->->
            - else:
                <> Failure...
                ->->
            }

        - success:
            <> Success!
            ->->

        - exceptionalSuccess:
            <> Exceptional Success!
            ->->
    }
    
    ->->

=== challengeCheckWithEffortRecursive(recursion_depth, required_effort, maximum_tries, applicable_trait, applicable_concepts, applicable_perks)

    // DEBUG: effortChallengeRecursive({recursion_depth}, {required_effort}, {maximum_tries}, {applicable_trait}, {applicable_concepts}, {applicable_perks})
    // DEBUG: {challengeEffortProgress} >= {required_effort}
    
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
    -> challengeCheckWithEffortRecursive(1 + recursion_depth, required_effort, maximum_tries, applicable_trait, applicable_concepts, applicable_perks) ->

    ->->

=== challengeCheckWithEffort(required_effort, maximum_tries, target_difficulty, applicable_trait, applicable_concepts, applicable_perks, applicable_quirks, -> goto_failure, -> goto_crit_failure)

    // target_difficulty has been converted to challengeDifficulty in setup; nothing else should use target_difficulty
    -> challengeSetup(target_difficulty, applicable_quirks) ->

    // effort counts up from 0 to required_effort threshold
    ~ challengeEffortProgress = 0
    
    // 1 is a magic number - this is the first time this recursive method is being called
    -> challengeCheckWithEffortRecursive(1, required_effort, maximum_tries, applicable_trait, applicable_concepts, applicable_perks) ->
    
    {
    - challengeEffortProgress == 0:
        ->-> goto_crit_failure
    - challengeEffortProgress < required_effort:
        ->-> goto_failure
    }

    ->->

=== challengeCheck (target_difficulty, applicable_trait, applicable_concepts, applicable_perks, applicable_quirks, -> goto_failure, -> goto_crit_failure)

    // target_difficulty has been converted to challengeDifficulty in setup; nothing else should use target_difficulty
    -> challengeSetup(target_difficulty, applicable_quirks) ->

    // do the roll, considering concepts and perks
    -> doOneChallengeRoll(applicable_trait, applicable_concepts, applicable_perks) ->
    
    // short circuit if the resolution is not favorable
    { challengeResolution:
    - criticalFailure:
        ->-> goto_crit_failure
    - failure:
        ->-> goto_failure
    }

    ->->
