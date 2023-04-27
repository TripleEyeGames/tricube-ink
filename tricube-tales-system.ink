INCLUDE tricube-tales-system-private.ink

//*******************************
//*                             *
//*  GAMEPLAY HELPER FUNCTIONS  *
//*                             *
//*******************************

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

=== offerToApplyComplication(optional_complication, applicable_quirks)

    {
        // short circuit if the complication has already been applied
        - storyComplications ? optional_complication:
            ->->

        // short circuit if the character already has max karma
        - characterKarma >= MAX_KARMA:
            ->->
    }
    
    {
    - LIST_COUNT(applicable_quirks) > 0 and applicable_quirks ? characterQuirk:
        You can recover some karma by being {characterQuirk} and taking on {optional_complication}.
            + {characterKarma < MAX_KARMA} [Take the complication.]
                ~ storyComplications += optional_complication
                ~ recoverKarma()
                ->->
            + [Continue as-is.]
                ->->
            -
                ->->
    }

=== challengeCheckWithEffortAndTimeout(target_difficulty, required_effort, maximum_tries, applicable_trait, applicable_concepts, applicable_perks, applicable_quirks, -> goto_timeout)

    {
        - maximum_tries > MAX_EFFORT_TRIES:
        !!! ERROR: The storyteller tried to give too many tries ({maximum_tries} vs {MAX_EFFORT_TRIES} max.)
        ->-> goto_timeout
    }

    // effort counts up from 0 to required_effort threshold
    ~ challengeEffortProgress = 0
    
    // 1 is a magic number - this is the first time this recursive method is being called
    -> challengeCheckWithEffortRecursive(1, required_effort, maximum_tries, target_difficulty, applicable_trait, applicable_concepts, applicable_perks, applicable_quirks) ->
    
    {showDebugMessages:{challengeEffortProgress} < {required_effort}? {challengeEffortProgress < required_effort}}
    
    {
    - challengeEffortProgress < required_effort:
        ->-> goto_timeout
    }

    ->->

=== challengeCheck (target_difficulty, applicable_trait, applicable_concepts, applicable_perks, applicable_quirks, -> goto_failure, -> goto_crit_failure)

    // target_difficulty has been converted to challengeDifficulty in setup; nothing else should use target_difficulty
    -> challengeRollSetup(target_difficulty, applicable_quirks) ->

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
