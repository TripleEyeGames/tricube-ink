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

// internal game data

CONST MAX_EFFORT_TRIES = 20
VAR __private__challengeEffortProgress = 0

VAR __private__challengeQuirkActive = false
VAR __private__hasPlayerDisengaged = false

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

=== function __private__getRollResolutionRecursive(which_dice, difficulty_level_to_check)
    
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
            ~ return __private__getRollResolutionRecursive(which_dice, challengeDifficulty(LIST_VALUE(difficulty_level_to_check) + 1))
    }

=== function __private__countSuccesses(difficulty)
    ~ temp number_of_successes = 0
    { challengeDice ? d1 && __private__getRollResolutionRecursive(d1, difficulty) == challengeResolution.success:
        ~ number_of_successes++
    }
    { challengeDice ? d2 && __private__getRollResolutionRecursive(d2, difficulty) == challengeResolution.success:
        ~ number_of_successes++
    }
    { challengeDice ? d3 && __private__getRollResolutionRecursive(d3, difficulty) == challengeResolution.success:
        ~ number_of_successes++
    }
    
    ~ return number_of_successes

=== function __private__checkRollResults(difficulty)

    ~ temp combined_roll_results = ()
    ~ combined_roll_results = __private__getRollResolutionRecursive(d1, difficulty) + __private__getRollResolutionRecursive(d2, difficulty) + __private__getRollResolutionRecursive(d3, difficulty)
    { 
        // if we have only critical failures, then it is a critical failure
        - combined_roll_results == challengeResolution.criticalFailure:
            ~ return challengeResolution.criticalFailure

        // if we have no successes, then it is a failure
        - combined_roll_results !? (challengeResolution.success):
            ~ return challengeResolution.failure
    }
    
    // count successes
    ~ temp number_of_successes = __private__countSuccesses(difficulty)

    // check for exceptional success
    { number_of_successes:
    - 1:
        ~ return challengeResolution.success
    - else:
        ~ return challengeResolution.exceptionalSuccess
    }

=== function __private__rollRecursive(number_of_dice)

    {
    - number_of_dice > MAX_DICE:
        !!! ERROR: The storyteller is trying to roll {number_of_dice} when there are only {MAX_DICE} dice max.
    - number_of_dice > 0:
        {showDebugMessages:rollRecursive - {LIST_MAX(LIST_ALL(challengeDifficulty))}({LIST_VALUE(LIST_MAX(LIST_ALL(challengeDifficulty)))})}
        ~ temp rolled_value = RANDOM(1, LIST_VALUE(LIST_MAX(LIST_ALL(challengeDifficulty))))

        ~ temp dice_offset = (number_of_dice * 10) + rolled_value
        ~ challengeDice += challengeDice(dice_offset)

        ~ challengeDice += challengeDice(number_of_dice * 10)
        ~ __private__rollRecursive(number_of_dice - 1)
    // number_of_dice <= 0: recursion complete
    }

    ~ return

=== function __private__rollDice(number_of_dice, difficulty)

    ~ challengeDice = ()
    ~ __private__rollRecursive(number_of_dice)
    ~ return __private__checkRollResults(difficulty)

=== __private__chooseQuirkPayout()

    {
        // short circuit if a quirk is not currently active
        - not __private__challengeQuirkActive:
            ->->
    }
    
    // turning off the flag, regardless of what happens next
    ~ __private__challengeQuirkActive = false

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

=== __private__offerToApplyQuirkToChallengeRoll(applicable_quirks)

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
                ~ __private__challengeQuirkActive = true
                ->->
            + [Continue as-is.]
                ->->
            -
                ->->
    }

=== __private__challengeRollSetup(target_difficulty, applicable_quirks)

    // setting base values for internal checks
    ~ challengeResolution = ()
    ~ __private__challengeQuirkActive = false

    ~ challengeDifficulty = target_difficulty

    // difficulty can be increased (if the player opts-in)
    -> __private__offerToApplyQuirkToChallengeRoll(applicable_quirks) ->
    
    ->->

=== __private__offerToUseKarmaInChallengeRoll()

    - You've failed, but a little karma goes a long way.
        + [Use your {getCharacterPerkDescription(characterPerk)} (and 1 karma) to succeed.]
            {
                - loseKarma():
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

=== __private__doOneChallengeRoll(applicable_trait, applicable_concepts, applicable_perks)

    ~temp dice_to_roll = 1
    {
        - applicable_trait == characterTrait:
            ~ dice_to_roll = 3
        - applicable_concepts ? characterConcept:
            ~ dice_to_roll = 2
    }

    // DO THE CHECK
    ~ challengeResolution = __private__rollDice(dice_to_roll, challengeDifficulty)
    {showDebugMessages:<> - {challengeDice} - {challengeResolution}}

    -> __private__chooseQuirkPayout() ->
    
    { challengeResolution:
        - criticalFailure:
            {showRollResults:<> Critical Failure...}
            ->->

        - failure:
            // if you have an applicable perk, and it would result in turning this failure to a success...
            {
            - characterKarma > 0 and applicable_perks ? characterPerk and (success, exceptionalSuccess) ? __private__checkRollResults(challengeDifficulty - 1):
                -> __private__offerToUseKarmaInChallengeRoll ->
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

=== __private__offerToDisengageBeforeChallengeRoll(challenge_type, required_effort)
    // if this is a dangerous challenge, we need to offer disengage
    - You have {characterResolve} resolve left, with {required_effort - __private__challengeEffortProgress} effort still to remove. Do you want to disengage?
    + [Yes - let's stop.]
        ~ __private__hasPlayerDisengaged = true
        ->->
    + [No; let's keep trying.]
        ->->

    ->->
    
=== __private__challengeCheckWithEffortRecursive(recursion_depth, challenge_type, target_difficulty, required_effort, maximum_tries, applicable_trait, applicable_concepts, applicable_perks, applicable_quirks)

    {
        // we're done!
        - __private__challengeEffortProgress >= required_effort:
            ->->
        
        // short circuit recursion if there's a limit set
        - maximum_tries > 0 && recursion_depth > maximum_tries:
            ->->
            
        // short circuit if we reach a maximum limit
        - recursion_depth >= MAX_EFFORT_TRIES:
            ->->

        // short circuit recursion if the character has lost their resolve
        - characterResolve <= 0:
            ->->
    }
    
    // if this is a dangerous challenge, we need to offer disengage
    {
        - challenge_type == dangerous and characterResolve < MAX_RESOLVE:
            -> __private__offerToDisengageBeforeChallengeRoll(challenge_type, required_effort) ->

            { __private__hasPlayerDisengaged: ->-> }
    }
    
    // target_difficulty has been converted to challengeDifficulty in setup; nothing else should use target_difficulty
    -> __private__challengeRollSetup(target_difficulty, applicable_quirks) ->

    {showDebugMessages: {__private__challengeEffortProgress} progress vs {required_effort} effort}

    // do the check
    -> __private__doOneChallengeRoll(applicable_trait, applicable_concepts, applicable_perks) ->
    
    // advance our counter on successes
    // take damage on failures, if the check is dangerous
    { challengeResolution:
    - criticalFailure:
    {
        - challenge_type == dangerous:
            You critically failed the roll, and lost two resolve!
            ~ loseResolve()
            ~ loseResolve()
    }

    - failure:
    {
        - challenge_type == dangerous:
            You failed the roll, and lost one resolve.
            ~ loseResolve()
    }

    - success:
        ~ __private__challengeEffortProgress++

    - exceptionalSuccess:
        ~ __private__challengeEffortProgress += __private__countSuccesses(challengeDifficulty)
    }
    
    // continue recursive loop
    -> __private__challengeCheckWithEffortRecursive(1 + recursion_depth, challenge_type, target_difficulty, required_effort, maximum_tries, applicable_trait, applicable_concepts, applicable_perks, applicable_quirks) ->

    ->->

