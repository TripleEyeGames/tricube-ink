INCLUDE tricube-tales-pocket-adventures.ink

// these list is part of the character definition for your story
// we need to add it here to test the core functions
LIST characterTrait = trait1, trait2, trait3
LIST characterConcept = concept1, concept2, concept3
LIST characterPerk = perk1, perk2, perk3
LIST characterQuirk = quirk1, quirk2, quirk3

LIST storyComplications = complication1, complication2, complication3

Which test suite do you want to run?
-> __testing__testSuiteSelection ->

// these functions are part of the character definition for your story
// we need to add them here to test the core functions
=== function getCharacterTraitDescription(player_trait)
    ~ return player_trait
    
=== function getCharacterConceptDescription(player_concept)
    ~ return player_concept
    
=== function getCharacterPerkDescription(character_perk)
    ~ return character_perk
    
=== function getCharacterQuirkDescription(player_quirk)
    ~ return player_quirk

=== __testing__getRollResolutionRecursiveTests
    // crit fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1)
    __private__getRollResolutionRecursive - Critical Failure - 1 die ({challengeDice}) vs 5: {__private__getRollResolutionRecursive(d1, standard) == criticalFailure:✔|<b>!!!</b>}
    
    // fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_2)
    __private__getRollResolutionRecursive - Failure - 1 die ({challengeDice}) vs 4: {__private__getRollResolutionRecursive(d1, easy) == failure:✔|<b>!!!</b>}
    
    // fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_5)
    __private__getRollResolutionRecursive - Failure - 1 die ({challengeDice}) vs 6: {__private__getRollResolutionRecursive(d1, hard) == failure:✔|<b>!!!</b>}
    
    // success
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_4)
    __private__getRollResolutionRecursive - Success - 1 die ({challengeDice}) vs 4: {__private__getRollResolutionRecursive(d1, easy) == success:✔|<b>!!!</b>}
    
    // success
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_6)
    __private__getRollResolutionRecursive - Success - 1 die ({challengeDice}) vs 6: {__private__getRollResolutionRecursive(d1, hard) == success:✔|<b>!!!</b>}

    ->->

=== __testing__checkRollResultsTests
    // crit fail - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1)
    __private__checkRollResults - Critical Failure - 1 die ({challengeDice}) vs 5: {__private__checkRollResults(standard) == criticalFailure:✔|<b>!!!</b>}
    
    // crit fail - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_1)
    __private__checkRollResults - Critical Failure - 2 die ({challengeDice}) vs 5: {__private__checkRollResults(standard) == criticalFailure:✔|<b>!!!</b>}
    
    // crit fail - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_1, d3, d3_1)
    __private__checkRollResults - Critical Failure - 3 die ({challengeDice}) vs 5: {__private__checkRollResults(standard) == criticalFailure:✔|<b>!!!</b>}
    
    // fail - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3)
    __private__checkRollResults - Failure - 1 die ({challengeDice}) vs 5: {__private__checkRollResults(standard) == failure:✔|<b>!!!</b>}
    
    // fail - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3, d2, d2_4)
    __private__checkRollResults - Failure - 2 die ({challengeDice}) vs 5: {__private__checkRollResults(standard) == failure:✔|<b>!!!</b>}
    
    // fail - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_2, d3, d3_3)
    __private__checkRollResults - Failure - 3 die ({challengeDice}) vs 5: {__private__checkRollResults(standard) == failure:✔|<b>!!!</b>}
    
    // success - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_5)
    __private__checkRollResults - Success - 1 die ({challengeDice}) vs 5: {__private__checkRollResults(standard) == success:✔|<b>!!!</b>}
    
    // success - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3, d2, d2_6)
    __private__checkRollResults - Success - 2 die ({challengeDice}) vs 5: {__private__checkRollResults(standard) == success:✔|<b>!!!</b>}
    
    // success - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_2, d3, d3_6)
    __private__checkRollResults - Success - 3 die ({challengeDice}) vs 5: {__private__checkRollResults(standard) == success:✔|<b>!!!</b>}
    
    // exceptional success - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_6, d2, d2_6)
    __private__checkRollResults - Exceptional Success - 2 die ({challengeDice}) vs 5: {__private__checkRollResults(standard) == exceptionalSuccess:✔|<b>!!!</b>}
    
    // exceptional success - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_5, d3, d3_6)
    __private__checkRollResults - Exceptional Success - 3 die ({challengeDice}) vs 5: {__private__checkRollResults(standard) == exceptionalSuccess:✔|<b>!!!</b>}
    
    ->->

=== __testing__rollDiceTests
    
    // 1 die
    <tt>__private__rollDice - 1 die vs 4: {__private__rollDice(1, easy)} ({challengeDice})
    <tt>...................... {__private__rollDice(1, easy)} ({challengeDice})
    <tt>...................... {__private__rollDice(1, easy)} ({challengeDice})
    <tt>...................... {__private__rollDice(1, easy)} ({challengeDice})
    <tt>__private__rollDice - 1 die vs 5: {__private__rollDice(1, standard)} ({challengeDice})
    <tt>...................... {__private__rollDice(1, standard)} ({challengeDice})
    <tt>...................... {__private__rollDice(1, standard)} ({challengeDice})
    <tt>...................... {__private__rollDice(1, standard)} ({challengeDice})
    <tt>__private__rollDice - 1 die vs 6: {__private__rollDice(1, hard)} ({challengeDice})
    <tt>...................... {__private__rollDice(1, hard)} ({challengeDice})
    <tt>...................... {__private__rollDice(1, hard)} ({challengeDice})
    <tt>...................... {__private__rollDice(1, hard)} ({challengeDice})
    
    // 2 die
    <tt>__private__rollDice - 2 die vs 4: {__private__rollDice(2, easy)} ({challengeDice})
    <tt>...................... {__private__rollDice(2, easy)} ({challengeDice})
    <tt>...................... {__private__rollDice(2, easy)} ({challengeDice})
    <tt>...................... {__private__rollDice(2, easy)} ({challengeDice})
    <tt>__private__rollDice - 2 die vs 5: {__private__rollDice(2, standard)} ({challengeDice})
    <tt>...................... {__private__rollDice(2, standard)} ({challengeDice})
    <tt>...................... {__private__rollDice(2, standard)} ({challengeDice})
    <tt>...................... {__private__rollDice(2, standard)} ({challengeDice})
    <tt>__private__rollDice - 2 die vs 6: {__private__rollDice(2, hard)} ({challengeDice})
    <tt>...................... {__private__rollDice(2, hard)} ({challengeDice})
    <tt>...................... {__private__rollDice(2, hard)} ({challengeDice})
    <tt>...................... {__private__rollDice(2, hard)} ({challengeDice})
    
    // 3 die
    <tt>__private__rollDice - 3 die vs 4: {__private__rollDice(3, easy)} ({challengeDice})
    <tt>...................... {__private__rollDice(3, easy)} ({challengeDice})
    <tt>...................... {__private__rollDice(3, easy)} ({challengeDice})
    <tt>...................... {__private__rollDice(3, easy)} ({challengeDice})
    <tt>__private__rollDice - 3 die vs 5: {__private__rollDice(3, standard)} ({challengeDice})
    <tt>...................... {__private__rollDice(3, standard)} ({challengeDice})
    <tt>...................... {__private__rollDice(3, standard)} ({challengeDice})
    <tt>...................... {__private__rollDice(3, standard)} ({challengeDice})
    <tt>__private__rollDice - 3 die vs 6: {__private__rollDice(3, hard)} ({challengeDice})
    <tt>...................... {__private__rollDice(3, hard)} ({challengeDice})
    <tt>...................... {__private__rollDice(3, hard)} ({challengeDice})
    <tt>...................... {__private__rollDice(3, hard)} ({challengeDice})
    
    ->->

=== __testing__useKarmaTests

    // use once - failure
    ~ characterKarma = 0
    loseKarma - 0 remains 0: {not loseKarma() and characterKarma == 0:✔|<b>!!!</b>}
    
    // use once - success
    ~ characterKarma = MAX_KARMA
    loseKarma - 3 becomes 2: {loseKarma() and characterKarma == 2:✔|<b>!!!</b>}

    // recover once - failure
    ~ characterKarma = MAX_KARMA
    recoverKarma - 3 remains 3: {not recoverKarma() and characterKarma == MAX_KARMA:✔|<b>!!!</b>}
    
    // recover once - success
    ~ characterKarma = 0
    rescoverKarma - 0 becomes 1: {recoverKarma() and characterKarma == 1:✔|<b>!!!</b>}
    
    ->->

=== __testing__resolveTests

    // use once - failure
    ~ characterResolve = 1
    loseResolve(dangerous) - 1 remains 1: {not loseResolve() and characterResolve == 1:✔|<b>!!!</b>}
    
    // use once - success
    ~ characterResolve = MAX_RESOLVE
    loseResolve(dangerous) - 3 becomes 2: {loseResolve() and characterResolve == 2:✔|<b>!!!</b>}

    // recover once - failure
    ~ characterResolve = MAX_RESOLVE
    recoverResolve - 3 remains 3: {not recoverResolve() and characterResolve == MAX_RESOLVE:✔|<b>!!!</b>}
    
    // recover once - success
    ~ characterResolve = 0
    recoverResolve - 0 becomes 1: {recoverResolve() and characterResolve == 1:✔|<b>!!!</b>}
    
    ->->

=== __testing__offerToApplyQuirkOnChallengeRollTests
    - Some of these tests require manual intervention:
    -> __testing__offerToApplyQuirkOnChallengeRollTestsLoop

=== __testing__offerToApplyQuirkOnChallengeRollTestsLoop
    // skip - max difficulty
    * [Max Difficulty Check]
        ~ challengeDifficulty = hard
        ~ __private__challengeQuirkActive = false
    
        ~ characterKarma = 1
        ~ characterResolve = MAX_RESOLVE
        ~ characterQuirk = quirk1
        
        -> __private__offerToApplyQuirkToChallengeRoll((quirk1)) ->
        __private__offerToApplyQuirkToChallengeRoll - max difficulty skip - {challengeDifficulty == hard and not __private__challengeQuirkActive:✔|<b>!!!</b>}
        
        -> __testing__offerToApplyQuirkOnChallengeRollTestsLoop

    // skip - quirk miss
    * [Quirk List Miss Check]
        ~ challengeDifficulty = easy
        ~ __private__challengeQuirkActive = false
    
        ~ characterKarma = 1
        ~ characterResolve = 1
        ~ characterQuirk = quirk2
        
        -> __private__offerToApplyQuirkToChallengeRoll((quirk1)) ->
        __private__offerToApplyQuirkToChallengeRoll - quirk miss skip - {challengeDifficulty == easy and not __private__challengeQuirkActive:✔|<b>!!!</b>}
        
        -> __testing__offerToApplyQuirkOnChallengeRollTestsLoop

    // skip - max karma & resolve
    * [Max Karma and Resolve Check]
        ~ challengeDifficulty = easy
        ~ __private__challengeQuirkActive = false
    
        ~ characterKarma = MAX_KARMA
        ~ characterResolve = MAX_RESOLVE
        ~ characterQuirk = quirk1
        
        -> __private__offerToApplyQuirkToChallengeRoll((quirk1)) ->
        __private__offerToApplyQuirkToChallengeRoll - max karma & resolve skip - {challengeDifficulty == easy and not __private__challengeQuirkActive:✔|<b>!!!</b>}
        
        -> __testing__offerToApplyQuirkOnChallengeRollTestsLoop

    // quirk offer made - karma
    * [Accept Quirk, Accept Karma Bump Check]
        ~ challengeDifficulty = easy
        ~ __private__challengeQuirkActive = false
    
        ~ characterKarma = 1
        ~ characterResolve = MAX_RESOLVE
        ~ characterQuirk = quirk1
        
        __private__offerToApplyQuirkToChallengeRoll - offer made (karma)
        -> __private__offerToApplyQuirkToChallengeRoll((quirk1)) ->
        __private__offerToApplyQuirkToChallengeRoll - quirk offer accepted - {challengeDifficulty == standard and __private__challengeQuirkActive:✔|<b>!!!</b>}
        
        __private__chooseQuirkPayout - please pick +1 Karma
        -> __private__chooseQuirkPayout ->
        __private__chooseQuirkPayout - results - {not __private__challengeQuirkActive and characterKarma == 2:✔|<b>!!!</b>}
        
        -> __testing__offerToApplyQuirkOnChallengeRollTestsLoop

    // quirk offer made - karma
    * [Accept Quirk, Refuse Karma Bump Check]
        ~ challengeDifficulty = easy
        ~ __private__challengeQuirkActive = false
    
        ~ characterKarma = 1
        ~ characterResolve = MAX_RESOLVE
        ~ characterQuirk = quirk1
        
        __private__offerToApplyQuirkToChallengeRoll - offer made (karma)
        -> __private__offerToApplyQuirkToChallengeRoll((quirk1)) ->
        __private__offerToApplyQuirkToChallengeRoll - quirk offer accepted - {challengeDifficulty == standard and __private__challengeQuirkActive:✔|<b>!!!</b>}
        
        __private__chooseQuirkPayout - please pick Nothing
        -> __private__chooseQuirkPayout ->
        __private__chooseQuirkPayout - results - {not __private__challengeQuirkActive and characterKarma == 1:✔|<b>!!!</b>}
        
        -> __testing__offerToApplyQuirkOnChallengeRollTestsLoop

    // quirk offer made - resolve
    * [Accept Quirk, Accept Resolve Bump Check]
        ~ challengeDifficulty = easy
        ~ __private__challengeQuirkActive = false
    
        ~ characterKarma = MAX_KARMA
        ~ characterResolve = 2
        ~ characterQuirk = quirk1
        
        __private__offerToApplyQuirkToChallengeRoll - offer made (resolve)
        -> __private__offerToApplyQuirkToChallengeRoll((quirk1)) ->
        __private__offerToApplyQuirkToChallengeRoll - quirk offer accepted - {challengeDifficulty == standard and __private__challengeQuirkActive:✔|<b>!!!</b>}
        
        // resolve payout only available if the challenge was a success
        ~ challengeResolution = success
        
        __private__chooseQuirkPayout - please pick +1 Resolve
        -> __private__chooseQuirkPayout ->
        __private__chooseQuirkPayout - results - {not __private__challengeQuirkActive and characterResolve == 3:✔|<b>!!!</b>}

        -> __testing__offerToApplyQuirkOnChallengeRollTestsLoop

    // quirk offer made - resolve
    * [Accept Quirk, Fail Challenge, No Resolve Bump Check]
        ~ challengeDifficulty = easy
        ~ __private__challengeQuirkActive = false
    
        ~ characterKarma = MAX_KARMA
        ~ characterResolve = 2
        ~ characterQuirk = quirk1
        
        __private__offerToApplyQuirkToChallengeRoll - offer made (resolve)
        -> __private__offerToApplyQuirkToChallengeRoll((quirk1)) ->
        __private__offerToApplyQuirkToChallengeRoll - quirk offer accepted - {challengeDifficulty == standard and __private__challengeQuirkActive:✔|<b>!!!</b>}
        
        // resolve payout only available if the challenge was a success
        ~ challengeResolution = criticalFailure
        
        __private__chooseQuirkPayout - challenge failed, nothing offered
        -> __private__chooseQuirkPayout ->
        __private__chooseQuirkPayout - results - {not __private__challengeQuirkActive and characterResolve == 2:✔|<b>!!!</b>}

        -> __testing__offerToApplyQuirkOnChallengeRollTestsLoop

    // quirk offer made - karma
    * [Accept Quirk, Accept Either Bump Check]
        ~ challengeDifficulty = standard
        ~ __private__challengeQuirkActive = false
    
        ~ characterKarma = 1
        ~ characterResolve = 1
        ~ characterQuirk = quirk1
        
        __private__offerToApplyQuirkToChallengeRoll - offer made (karma)
        -> __private__offerToApplyQuirkToChallengeRoll((quirk1)) ->
        __private__offerToApplyQuirkToChallengeRoll - quirk offer accepted - {challengeDifficulty == hard and __private__challengeQuirkActive:✔|<b>!!!</b>}
        
        // resolve payout only available if the challenge was a success
        ~ challengeResolution = success

        __private__chooseQuirkPayout - please pick +1 Either
        -> __private__chooseQuirkPayout ->
        __private__chooseQuirkPayout - results - {not __private__challengeQuirkActive and (characterKarma == 2 or characterResolve ==2):✔|<b>!!!</b>}
        
        -> __testing__offerToApplyQuirkOnChallengeRollTestsLoop

    + [Finish Quirk Tests]
        ->->

=== __testing__offerComplicationTests
    - Some of these tests require manual intervention:
    -> __testing__offerComplicationTestsLoop

=== __testing__offerComplicationTestsLoop
    // skip - max karma
    * [Max Karma Check]
        ~ characterKarma = MAX_KARMA
        ~ characterQuirk = quirk1
        
        ~ storyComplications = ()
        
        -> offerComplication(complication1,quirk1) ->
        offerComplication - max karma skip - {characterKarma == MAX_KARMA and storyComplications !? complication1:✔|<b>!!!</b>}
        
        -> __testing__offerComplicationTestsLoop
    
    // skip - complication already set
    * [Duplicate Complication Check]
        ~ characterKarma = 1
        ~ characterQuirk = quirk2
        
        ~ storyComplications = complication1
        
        -> offerComplication(complication1,quirk2) ->
        offerComplication - duplicate complication skip - {characterKarma == 1 and storyComplications ? complication1:✔|<b>!!!</b>}
        
        -> __testing__offerComplicationTestsLoop
    
    // complication offer made & accepted
    * [Accept Complication Check]
        ~ characterKarma = 1
        ~ characterQuirk = quirk3
        
        ~ storyComplications = complication2
        
        offerComplication - please take the complication
        -> offerComplication(complication3,quirk3) ->
        offerComplication - complication offer accepted - {characterKarma == 2 and storyComplications ? complication3:✔|<b>!!!</b>}
        
        -> __testing__offerComplicationTestsLoop
    
    // complication offer made & refused
    * [Refuse Complication Check]
        ~ characterKarma = 1
        ~ characterQuirk = quirk3
        
        ~ storyComplications = complication2
        
        offerComplication - please continue as-is
        -> offerComplication(complication3,quirk3) ->
        offerComplication - complication offer rejected - {characterKarma == 1 and storyComplications !? complication3:✔|<b>!!!</b>}
        
        -> __testing__offerComplicationTestsLoop
    
    + [Finished Complications Tests]
        ->->

=== __testing__challengeCheckTests
    - Some of these tests require manual intervention:
    -> __testing__challengeCheckTestsLoop

=== __testing__challengeCheckTestsLoop
    // The presets for every challenge test
    ~ characterKarma = MAX_KARMA
    ~ characterResolve = MAX_RESOLVE
    ~ characterTrait = trait3
    ~ characterConcept = concept2
    ~ characterPerk = perk1
    ~ characterQuirk = quirk2
    
    ~ storyComplications = ()

    + [1 Die, 4 Difficulty, No Perk Match]
        challengeCheck(easy) <>
        -> challengeCheck (easy, (), (), (), (), -> __testing__challengeCheckTestsFailure, -> __testing__challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckTestsLoop

    + [1 Die, 5 Difficulty, No Perk Match]
        challengeCheck(standard) <>
        -> challengeCheck (standard, (), (), (), (), -> __testing__challengeCheckTestsFailure, -> __testing__challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckTestsLoop

    + [1 Die, 6 Difficulty, No Perk Match]
        challengeCheck(hard) <>
        -> challengeCheck (hard, (), (), (), (), -> __testing__challengeCheckTestsFailure, -> __testing__challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckTestsLoop

    + [1 Die, 4 Difficulty, Perk Match]
        challengeCheck(easy) <>
        -> challengeCheck (easy, (), (), perk1, (), -> __testing__challengeCheckTestsFailure, -> __testing__challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckTestsLoop

    + [1 Die, 5 Difficulty, Perk Match]
        challengeCheck(standard) <>
        -> challengeCheck (standard, (), (), perk1, (), -> __testing__challengeCheckTestsFailure, -> __testing__challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckTestsLoop

    + [1 Die, 6 Difficulty, Perk Match]
        challengeCheck(hard) <>
        -> challengeCheck (hard, (), (), perk1, (), -> __testing__challengeCheckTestsFailure, -> __testing__challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckTestsLoop

    + [Finish Challenge Check Tests]
        ->->

=== __testing__challengeCheckTestsFailure
    The challenge failed.
    -> __testing__challengeCheckTestsLoop

=== __testing__challengeCheckWithEffortVersusTimerTests
    - Some of these tests require manual intervention:
    -> __testing__challengeCheckWithEffortVersusTimerTestsLoop

=== __testing__challengeCheckWithEffortVersusTimerTestsLoop
    // The presets for every challenge test
    ~ characterKarma = MAX_KARMA
    ~ characterResolve = MAX_RESOLVE
    ~ characterTrait = trait1
    ~ characterConcept = concept3
    ~ characterPerk = perk2
    ~ characterQuirk = quirk3
    
    ~ storyComplications = ()
    
    // failure cases
    + [Too Many ({MAX_EFFORT_TRIES+1}) Tries]
        challengeCheckWithEffortVersusTimer(easy, 1, {MAX_EFFORT_TRIES+1})
        -> challengeCheckWithEffortVersusTimer (easy, 1, MAX_EFFORT_TRIES+1, (), (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop

    // 1 Effort Section
    + [1 Die, 1 Effort, 10 Tries, 4 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(easy, 1, 10)
        -> challengeCheckWithEffortVersusTimer (easy, 1, 10, (), (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop
        
    + [1 Die, 1 Effort, 10 Tries, 5 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(standard, 1, 10)
        -> challengeCheckWithEffortVersusTimer (standard, 1, 10, (), (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop
        
    + [1 Die, 1 Effort, 10 Tries, 6 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(hard, 1, 10)
        -> challengeCheckWithEffortVersusTimer (hard, 1, 10, (), (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop
    
    + [3 Die, 1 Effort, 10 Tries, 4 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(easy, 1, 10)
        -> challengeCheckWithEffortVersusTimer (easy, 1, 10, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop
        
    + [3 Die, 1 Effort, 10 Tries, 5 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(standard, 1, 10)
        -> challengeCheckWithEffortVersusTimer (standard, 1, 10, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop
        
    + [3 Die, 1 Effort, 10 Tries, 6 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(hard, 1, 10)
        -> challengeCheckWithEffortVersusTimer (hard, 1, 10, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop
    
    // 10 Effort Section
    + [1 Die, 10 Effort, max. tries, 4 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(easy, 10, 30)
        -> challengeCheckWithEffortVersusTimer (easy, 10, MAX_EFFORT_TRIES, (), (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop

    + [1 Die, 10 Effort, max. tries, 5 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(standard, 10, 30)
        -> challengeCheckWithEffortVersusTimer (standard, 10, MAX_EFFORT_TRIES, (), (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop

    + [1 Die, 10 Effort, max. tries, 6 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(hard, 10, 30)
        -> challengeCheckWithEffortVersusTimer (hard, 10, MAX_EFFORT_TRIES, (), (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop

    + [3 Die, 10 Effort, max. tries, 4 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(easy, 10, 30)
        -> challengeCheckWithEffortVersusTimer (easy, 10, 30, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop

    + [3 Die, 10 Effort, max. tries, 5 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(standard, 10, 30)
        -> challengeCheckWithEffortVersusTimer (standard, 10, 30, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop

    + [3 Die, 10 Effort, max. tries, 6 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusTimer(hard, 10, 30)
        -> challengeCheckWithEffortVersusTimer (hard, 10, 30, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusTimerTestsLoop

    + [Finish Challenge Check Tests]
        ->->

=== __testing__challengeCheckWithEffortVersusTimer_TimeoutDivert
    The challenge failed.
    -> __testing__challengeCheckWithEffortVersusTimerTestsLoop

=== __testing__challengeCheckWithEffortVersusResolveTests
    - Some of these tests require manual intervention:
    -> __testing__challengeCheckWithEffortVersusResolveTestsLoop

=== __testing__challengeCheckWithEffortVersusResolveTestsLoop
    // The presets for every challenge test
    ~ characterKarma = MAX_KARMA
    ~ characterResolve = MAX_RESOLVE
    ~ characterTrait = trait1
    ~ characterConcept = concept3
    ~ characterPerk = perk2
    ~ characterQuirk = quirk3
    
    ~ storyComplications = ()
    
    // 1 Effort Section
    + [1 Die, 1 Effort, 4 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(easy, 1)
        -> challengeCheckWithEffortVersusResolve (easy, 1, (), (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop
        
    + [1 Die, 1 Effort, 5 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(standard, 1)
        -> challengeCheckWithEffortVersusResolve (standard, 1, (), (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop
        
    + [1 Die, 1 Effort, 6 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(hard, 1)
        -> challengeCheckWithEffortVersusResolve (hard, 1, (), (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop
    
    + [3 Die, 1 Effort, 4 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(easy, 1)
        -> challengeCheckWithEffortVersusResolve (easy, 1, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop
        
    + [3 Die, 1 Effort, 5 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(standard, 1)
        -> challengeCheckWithEffortVersusResolve (standard, 1, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop
        
    + [3 Die, 1 Effort, 6 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(hard, 1, 10)
        -> challengeCheckWithEffortVersusResolve (hard, 1, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop
    
    // 10 Effort Section
    + [1 Die, 10 Effort, 4 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(easy, 10)
        -> challengeCheckWithEffortVersusResolve (easy, 10, (), (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop

    + [1 Die, 10 Effort, 5 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(standard, 10)
        -> challengeCheckWithEffortVersusResolve (standard, 10, (), (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop

    + [1 Die, 10 Effort, 6 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(hard, 10)
        -> challengeCheckWithEffortVersusResolve (hard, 10, (), (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop

    + [3 Die, 10 Effort, 4 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(easy, 10)
        -> challengeCheckWithEffortVersusResolve (easy, 10, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop

    + [3 Die, 10 Effort, 5 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(standard, 10)
        -> challengeCheckWithEffortVersusResolve (standard, 10, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop

    + [3 Die, 10 Effort, 6 Difficulty, No Perk Match]
        challengeCheckWithEffortVersusResolve(hard, 10)
        -> challengeCheckWithEffortVersusResolve (hard, 10, trait1, (), (), (), -> __testing__challengeCheckWithEffortVersusResolve_DisengageDivert, -> __testing__challengeCheckWithEffortVersusResolve_FailureDivert) ->
        
        The challenge succeeded!
        -> __testing__challengeCheckWithEffortVersusResolveTestsLoop

    + [Finish Challenge Check Tests]
        ->->

=== __testing__challengeCheckWithEffortVersusResolve_DisengageDivert
    The player disengaged from the challenge.
    -> __testing__challengeCheckWithEffortVersusResolveTestsLoop

=== __testing__challengeCheckWithEffortVersusResolve_FailureDivert
    The player lost all resolve during the challenge.
    -> __testing__challengeCheckWithEffortVersusResolveTestsLoop

=== __testing__testSuiteSelection ===
    // which test suite do you want to run?
    * [Roll Resolution Tests]
        <h1>ROLL RESOLUTION TESTS</h1>
        -> __testing__getRollResolutionRecursiveTests ->
        -> __testing__testSuiteSelection
    
    * [Check Roll Results Tests]
        <h1>CHECK ROLL RESULTS TESTS</h1>
        -> __testing__checkRollResultsTests ->
        -> __testing__testSuiteSelection
    
    * [Roll Tests]
        <h1>ROLL TESTS</h1>
        -> __testing__rollDiceTests ->
        -> __testing__testSuiteSelection
    
    * [Karma Tests]
        <h1>KARMA TESTS</h1>
        -> __testing__useKarmaTests ->
        -> __testing__testSuiteSelection
    
    * [Resolve Tests]
        <h1>RESOLVE TESTS</h1>
        -> __testing__resolveTests ->
        -> __testing__testSuiteSelection
    
    * [Apply Quirk Tests]
        <h1>APPLY QUIRK TESTS</h1>
        -> __testing__offerToApplyQuirkOnChallengeRollTests ->
        -> __testing__testSuiteSelection
    
    * [Apply Complications Tests]
        <h1>APPLY COMPLICATIONS TESTS</h1>
        -> __testing__offerComplicationTests ->
        -> __testing__testSuiteSelection
    
    * [Challenge Checks Tests]
        <h1>CHALLENGE CHECKS TESTS</h1>
        -> __testing__challengeCheckTests ->
        -> __testing__testSuiteSelection
    
    * [Effort Challenge (Vs Timer) Checks Tests]
        <h1>EFFORT CHALLENGE (VS TIMER) CHECKS TESTS</h1>
        -> __testing__challengeCheckWithEffortVersusTimerTests ->
        -> __testing__testSuiteSelection
    
    * [Effort Challenge (Vs Resolve) Checks Tests]
        <h1>EFFORT CHALLENGE (VS RESOLVE) CHECKS TESTS</h1>
        -> __testing__challengeCheckWithEffortVersusResolveTests ->
        -> __testing__testSuiteSelection
    
    * [Finish Tests]
        -> END
