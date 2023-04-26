INCLUDE tricube-system-tools.ink

// these list is part of the character definition for your story
// we need to add it here to test the core functions
LIST characterTrait = trait1, trait2, trait3
LIST characterConcept = concept1, concept2, concept3
LIST characterPerk = perk1, perk2, perk3
LIST characterQuirk = quirk1, quirk2, quirk3

LIST storyComplications = complication1, complication2, complication3

Which test do you want to run?
-> unitTests ->

// this function is part of the character definition for your story
// we need to add it here to test the core functions
=== function getCharacterPerkDescription(character_perk)
    ~ return character_perk

=== getRollResolutionRecursiveTests
    // crit fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1)
    getRollResolutionRecursive - Critical Failure - 1 die ({challengeDice}) vs 5: {getRollResolutionRecursive(d1, standard) == criticalFailure:✔|<b>!!!</b>}
    
    // fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_2)
    getRollResolutionRecursive - Failure - 1 die ({challengeDice}) vs 4: {getRollResolutionRecursive(d1, easy) == failure:✔|<b>!!!</b>}
    
    // fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_5)
    getRollResolutionRecursive - Failure - 1 die ({challengeDice}) vs 6: {getRollResolutionRecursive(d1, hard) == failure:✔|<b>!!!</b>}
    
    // success
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_4)
    getRollResolutionRecursive - Success - 1 die ({challengeDice}) vs 4: {getRollResolutionRecursive(d1, easy) == success:✔|<b>!!!</b>}
    
    // success
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_6)
    getRollResolutionRecursive - Success - 1 die ({challengeDice}) vs 6: {getRollResolutionRecursive(d1, hard) == success:✔|<b>!!!</b>}

    ->->

=== checkRollResultsTests
    // crit fail - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1)
    checkRollResults - Critical Failure - 1 die ({challengeDice}) vs 5: {checkRollResults(standard) == criticalFailure:✔|<b>!!!</b>}
    
    // crit fail - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_1)
    checkRollResults - Critical Failure - 2 die ({challengeDice}) vs 5: {checkRollResults(standard) == criticalFailure:✔|<b>!!!</b>}
    
    // crit fail - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_1, d3, d3_1)
    checkRollResults - Critical Failure - 3 die ({challengeDice}) vs 5: {checkRollResults(standard) == criticalFailure:✔|<b>!!!</b>}
    
    // fail - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3)
    checkRollResults - Failure - 1 die ({challengeDice}) vs 5: {checkRollResults(standard) == failure:✔|<b>!!!</b>}
    
    // fail - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3, d2, d2_4)
    checkRollResults - Failure - 2 die ({challengeDice}) vs 5: {checkRollResults(standard) == failure:✔|<b>!!!</b>}
    
    // fail - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_2, d3, d3_3)
    checkRollResults - Failure - 3 die ({challengeDice}) vs 5: {checkRollResults(standard) == failure:✔|<b>!!!</b>}
    
    // success - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_5)
    checkRollResults - Success - 1 die ({challengeDice}) vs 5: {checkRollResults(standard) == success:✔|<b>!!!</b>}
    
    // success - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3, d2, d2_6)
    checkRollResults - Success - 2 die ({challengeDice}) vs 5: {checkRollResults(standard) == success:✔|<b>!!!</b>}
    
    // success - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_2, d3, d3_6)
    checkRollResults - Success - 3 die ({challengeDice}) vs 5: {checkRollResults(standard) == success:✔|<b>!!!</b>}
    
    // exceptional success - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_6, d2, d2_6)
    checkRollResults - Exceptional Success - 2 die ({challengeDice}) vs 5: {checkRollResults(standard) == exceptionalSuccess:✔|<b>!!!</b>}
    
    // exceptional success - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_5, d3, d3_6)
    checkRollResults - Exceptional Success - 3 die ({challengeDice}) vs 5: {checkRollResults(standard) == exceptionalSuccess:✔|<b>!!!</b>}
    
    ->->

=== rollDiceTests
    
    // 1 die
    <tt>rollDice - 1 die vs 4: {rollDice(1, easy)} ({challengeDice})
    <tt>...................... {rollDice(1, easy)} ({challengeDice})
    <tt>...................... {rollDice(1, easy)} ({challengeDice})
    <tt>...................... {rollDice(1, easy)} ({challengeDice})
    <tt>rollDice - 1 die vs 5: {rollDice(1, standard)} ({challengeDice})
    <tt>...................... {rollDice(1, standard)} ({challengeDice})
    <tt>...................... {rollDice(1, standard)} ({challengeDice})
    <tt>...................... {rollDice(1, standard)} ({challengeDice})
    <tt>rollDice - 1 die vs 6: {rollDice(1, hard)} ({challengeDice})
    <tt>...................... {rollDice(1, hard)} ({challengeDice})
    <tt>...................... {rollDice(1, hard)} ({challengeDice})
    <tt>...................... {rollDice(1, hard)} ({challengeDice})
    
    // 2 die
    <tt>rollDice - 2 die vs 4: {rollDice(2, easy)} ({challengeDice})
    <tt>...................... {rollDice(2, easy)} ({challengeDice})
    <tt>...................... {rollDice(2, easy)} ({challengeDice})
    <tt>...................... {rollDice(2, easy)} ({challengeDice})
    <tt>rollDice - 2 die vs 5: {rollDice(2, standard)} ({challengeDice})
    <tt>...................... {rollDice(2, standard)} ({challengeDice})
    <tt>...................... {rollDice(2, standard)} ({challengeDice})
    <tt>...................... {rollDice(2, standard)} ({challengeDice})
    <tt>rollDice - 2 die vs 6: {rollDice(2, hard)} ({challengeDice})
    <tt>...................... {rollDice(2, hard)} ({challengeDice})
    <tt>...................... {rollDice(2, hard)} ({challengeDice})
    <tt>...................... {rollDice(2, hard)} ({challengeDice})
    
    // 3 die
    <tt>rollDice - 3 die vs 4: {rollDice(3, easy)} ({challengeDice})
    <tt>...................... {rollDice(3, easy)} ({challengeDice})
    <tt>...................... {rollDice(3, easy)} ({challengeDice})
    <tt>...................... {rollDice(3, easy)} ({challengeDice})
    <tt>rollDice - 3 die vs 5: {rollDice(3, standard)} ({challengeDice})
    <tt>...................... {rollDice(3, standard)} ({challengeDice})
    <tt>...................... {rollDice(3, standard)} ({challengeDice})
    <tt>...................... {rollDice(3, standard)} ({challengeDice})
    <tt>rollDice - 3 die vs 6: {rollDice(3, hard)} ({challengeDice})
    <tt>...................... {rollDice(3, hard)} ({challengeDice})
    <tt>...................... {rollDice(3, hard)} ({challengeDice})
    <tt>...................... {rollDice(3, hard)} ({challengeDice})
    
    ->->

=== useKarmaTests

    // use once - failure
    ~ characterKarma = 0
    useKarma - 0 remains 0: {not useKarma() and characterKarma == 0:✔|<b>!!!</b>}
    
    // use once - success
    ~ characterKarma = MAX_KARMA
    useKarma - 3 becomes 2: {useKarma() and characterKarma == 2:✔|<b>!!!</b>}

    // recover once - failure
    ~ characterKarma = MAX_KARMA
    recoverKarma - 3 remains 3: {not recoverKarma() and characterKarma == MAX_KARMA:✔|<b>!!!</b>}
    
    // recover once - success
    ~ characterKarma = 0
    rescoverKarma - 0 becomes 1: {recoverKarma() and characterKarma == 1:✔|<b>!!!</b>}
    
    ->->

=== resolveTests

    // use once - safe - failure
    ~ characterResolve = 1
    loseResolve(safe) - 1 remains 1: {not loseResolve(safe) and characterResolve == 1:✔|<b>!!!</b>}
    
    // use once - safe - success
    ~ characterResolve = MAX_RESOLVE
    loseResolve(safe) - 3 becomes 2: {loseResolve(safe) and characterResolve == 2:✔|<b>!!!</b>}

    // use once - dangerous - failure
    ~ characterResolve = 1
    loseResolve(dangerous) - 1 remains 1: {not loseResolve(dangerous) and characterResolve == 1:✔|<b>!!!</b>}
    
    // use once - dangerous - success
    ~ characterResolve = MAX_RESOLVE
    loseResolve(dangerous) - 3 becomes 1: {loseResolve(dangerous) and characterResolve == 1:✔|<b>!!!</b>}

    // recover once - failure
    ~ characterResolve = MAX_RESOLVE
    recoverResolve - 3 remains 3: {not recoverResolve() and characterResolve == MAX_RESOLVE:✔|<b>!!!</b>}
    
    // recover once - success
    ~ characterResolve = 0
    recoverResolve - 0 becomes 1: {recoverResolve() and characterResolve == 1:✔|<b>!!!</b>}
    
    ->->

=== offerToApplyQuirkOnChallengeRollTests
    - Some of these tests require manual intervention:
    -> offerToApplyQuirkOnChallengeRollTestsLoop

=== offerToApplyQuirkOnChallengeRollTestsLoop
    // skip - max difficulty
    * [Max Difficulty Check]
        ~ challengeDifficulty = MAX_DIFFICULTY
        ~ challengeDifficultyModifier = 0
        ~ challengeQuirkPayout = ()
    
        ~ characterKarma = 1
        ~ characterResolve = MAX_RESOLVE
        ~ characterQuirk = quirk1
        
        -> offerToApplyQuirkToChallengeRoll((quirk1)) ->
        offerToApplyQuirkToChallengeRoll - max difficulty skip - {challengeDifficultyModifier == 0 and not challengeQuirkPayout:✔|<b>!!!</b>}
        
        -> offerToApplyQuirkOnChallengeRollTestsLoop

    // skip - quirk miss
    * [Quirk List Miss Check]
        ~ challengeDifficulty = 4
        ~ challengeDifficultyModifier = 0
        ~ challengeQuirkPayout = ()
    
        ~ characterKarma = 1
        ~ characterResolve = 1
        ~ characterQuirk = quirk2
        
        -> offerToApplyQuirkToChallengeRoll((quirk1)) ->
        offerToApplyQuirkToChallengeRoll - quirk miss skip - {challengeDifficultyModifier == 0 and not challengeQuirkPayout:✔|<b>!!!</b>}
        
        -> offerToApplyQuirkOnChallengeRollTestsLoop

    // skip - max karma & resolve
    * [Max Karma and Resolve Check]
        ~ challengeDifficulty = 4
        ~ challengeDifficultyModifier = 0
        ~ challengeQuirkPayout = ()
    
        ~ characterKarma = MAX_KARMA
        ~ characterResolve = MAX_RESOLVE
        ~ characterQuirk = quirk1
        
        -> offerToApplyQuirkToChallengeRoll((quirk1)) ->
        offerToApplyQuirkToChallengeRoll - max karma & resolve skip - {challengeDifficultyModifier == 0 and not challengeQuirkPayout:✔|<b>!!!</b>}
        
        -> offerToApplyQuirkOnChallengeRollTestsLoop

    // quirk offer made - karma
    * [Accept Karma Bump Check]
        ~ challengeDifficulty = 4
        ~ challengeDifficultyModifier = 0
        ~ challengeQuirkPayout = ()
    
        ~ characterKarma = 1
        ~ characterResolve = MAX_RESOLVE
        ~ characterQuirk = quirk1
        
        offerToApplyQuirkToChallengeRoll - karma offer made - please pick +1 Karma
        -> offerToApplyQuirkToChallengeRoll((quirk1)) ->
        offerToApplyQuirkToChallengeRoll - quirk offer accepted - {challengeDifficultyModifier == 1 and challengeQuirkPayout == karma:✔|<b>!!!</b>}
        
        -> offerToApplyQuirkOnChallengeRollTestsLoop

    // quirk offer made - resolve
    * [Accept Resolve Bump Check]
        ~ challengeDifficulty = 4
        ~ challengeDifficultyModifier = 0
        ~ challengeQuirkPayout = ()
    
        ~ characterKarma = MAX_KARMA
        ~ characterResolve = 2
        ~ characterQuirk = quirk1
        
        offerToApplyQuirkToChallengeRoll - resolve offer made - please pick +1 Resolve
        -> offerToApplyQuirkToChallengeRoll((quirk1)) ->
        offerToApplyQuirkToChallengeRoll - quirk offer accepted - {challengeDifficultyModifier == 1 and challengeQuirkPayout == resolve:✔|<b>!!!</b>}
        
        -> offerToApplyQuirkOnChallengeRollTestsLoop

    + [Finish Quirk Tests]
        ->->

=== offerToApplyComplicationTests
    - Some of these tests require manual intervention:
    -> offerToApplyComplicationTestsLoop

=== offerToApplyComplicationTestsLoop
    // skip - max karma
    * [Max Karma Check]
        ~ characterKarma = MAX_KARMA
        ~ characterQuirk = quirk1
        
        ~ storyComplications = ()
        
        -> offerToApplyComplication(complication1,quirk1) ->
        offerToApplyComplication - max karma skip - {characterKarma == MAX_KARMA and storyComplications !? complication1:✔|<b>!!!</b>}
        
        -> offerToApplyComplicationTestsLoop
    
    // skip - complication already set
    * [Duplicate Complication Check]
        ~ characterKarma = 1
        ~ characterQuirk = quirk2
        
        ~ storyComplications = complication1
        
        -> offerToApplyComplication(complication1,quirk2) ->
        offerToApplyComplication - duplicate complication skip - {characterKarma == 1 and storyComplications ? complication1:✔|<b>!!!</b>}
        
        -> offerToApplyComplicationTestsLoop
    
    // complication offer made
    * [Accept Complication Check]
        ~ characterKarma = 1
        ~ characterQuirk = quirk3
        
        ~ storyComplications = complication2
        
        -> offerToApplyComplication(complication3,quirk3) ->
        offerToApplyComplication - complication offer accepted - {characterKarma == 2 and storyComplications ? complication3:✔|<b>!!!</b>}
        
        -> offerToApplyComplicationTestsLoop
    
    + [Finished Complications Tests]
        ->->

=== challengeCheckTests
    - Some of these tests require manual intervention:
    -> challengeCheckTestsLoop

=== challengeCheckTestsLoop
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
        -> challengeCheck (easy, (), (), (), (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 5 Difficulty, No Perk Match]
        challengeCheck(standard) <>
        -> challengeCheck (standard, (), (), (), (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 6 Difficulty, No Perk Match]
        challengeCheck(hard) <>
        -> challengeCheck (hard, (), (), (), (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 4 Difficulty, Perk Match]
        challengeCheck(easy) <>
        -> challengeCheck (easy, (), (), perk1, (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 5 Difficulty, Perk Match]
        challengeCheck(standard) <>
        -> challengeCheck (standard, (), (), perk1, (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 6 Difficulty, Perk Match]
        challengeCheck(hard) <>
        -> challengeCheck (hard, (), (), perk1, (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [Finish Challenge Check Tests]
        ->->

=== challengeCheckTestsFailure
    The challenge failed.
    -> challengeCheckTestsLoop

=== challengeCheckWithEffortTests
    - Some of these tests require manual intervention:
    -> challengeCheckWithEffortLoop

=== challengeCheckWithEffortLoop
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
        challengeCheckWithEffort(1, {MAX_EFFORT_TRIES+1}, 4)
        -> challengeCheckWithEffort (1, MAX_EFFORT_TRIES+1, easy, (), (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop

    // 1 Effort Section
    + [1 Die, 1 Effort, 10 Tries, 4 Difficulty, No Perk Match]
        challengeCheckWithEffort(1, 10, 4)
        -> challengeCheckWithEffort (1, 10, easy, (), (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop
        
    + [1 Die, 1 Effort, 10 Tries, 5 Difficulty, No Perk Match]
        challengeCheckWithEffort(1, 10, 5)
        -> challengeCheckWithEffort (1, 10, standard, (), (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop
        
    + [1 Die, 1 Effort, 10 Tries, 6 Difficulty, No Perk Match]
        challengeCheckWithEffort(1, 10, 6)
        -> challengeCheckWithEffort (1, 10, hard, (), (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop
    
    + [3 Die, 1 Effort, 10 Tries, 4 Difficulty, No Perk Match]
        challengeCheckWithEffort(1, 10, 4)
        -> challengeCheckWithEffort (1, 10, easy, trait1, (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop
        
    + [3 Die, 1 Effort, 10 Tries, 5 Difficulty, No Perk Match]
        challengeCheckWithEffort(1, 10, 5)
        -> challengeCheckWithEffort (1, 10, standard, trait1, (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop
        
    + [3 Die, 1 Effort, 10 Tries, 6 Difficulty, No Perk Match]
        challengeCheckWithEffort(1, 10, 6)
        -> challengeCheckWithEffort (1, 10, hard, trait1, (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop
    
    // 10 Effort Section
    + [1 Die, 10 Effort, 30 tries, 4 Difficulty, No Perk Match]
        challengeCheckWithEffort(10, 30, 4)
        -> challengeCheckWithEffort (10, 30, easy, (), (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop

    + [1 Die, 10 Effort, 30 tries, 5 Difficulty, No Perk Match]
        challengeCheckWithEffort(10, 30, 5)
        -> challengeCheckWithEffort (10, 30, standard, (), (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop

    + [1 Die, 10 Effort, 30 tries, 6 Difficulty, No Perk Match]
        challengeCheckWithEffort(10, 30, 6)
        -> challengeCheckWithEffort (10, 30, hard, (), (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop

    + [3 Die, 10 Effort, 30 tries, 4 Difficulty, No Perk Match]
        challengeCheckWithEffort(10, 30, 4)
        -> challengeCheckWithEffort (10, 30, easy, trait1, (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop

    + [3 Die, 10 Effort, 30 tries, 5 Difficulty, No Perk Match]
        challengeCheckWithEffort(10, 30, 5)
        -> challengeCheckWithEffort (10, 30, standard, trait1, (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop

    + [3 Die, 10 Effort, 30 tries, 6 Difficulty, No Perk Match]
        challengeCheckWithEffort(10, 30, 6)
        -> challengeCheckWithEffort (10, 30, hard, trait1, (), (), (), -> challengeCheckWithEffortTimeout) ->
        
        The challenge succeeded!
        -> challengeCheckWithEffortLoop

    + [Finish Challenge Check Tests]
        ->->

=== challengeCheckWithEffortTimeout
    The challenge failed.
    -> challengeCheckWithEffortLoop

=== unitTests ===
    // which test suite do you want to run?
    * [Roll Resolution Tests]
        <h1>ROLL RESOLUTION TESTS</h1>
        -> getRollResolutionRecursiveTests ->
        -> unitTests
    
    * [Check Roll Results Tests]
        <h1>CHECK ROLL RESULTS TESTS</h1>
        -> checkRollResultsTests ->
        -> unitTests
    
    * [Roll Tests]
        <h1>ROLL TESTS</h1>
        -> rollDiceTests ->
        -> unitTests
    
    * [Karma Tests]
        <h1>KARMA TESTS</h1>
        -> useKarmaTests ->
        -> unitTests
    
    * [Resolve Tests]
        <h1>RESOLVE TESTS</h1>
        -> resolveTests ->
        -> unitTests
    
    * [Apply Quirk Tests]
        <h1>APPLY QUIRK TESTS</h1>
        -> offerToApplyQuirkOnChallengeRollTests ->
        -> unitTests
    
    * [Apply Complications Tests]
        <h1>APPLY COMPLICATIONS TESTS</h1>
        -> offerToApplyComplicationTests ->
        -> unitTests
    
    * [Challenge Checks Tests]
        <h1>CHALLENGE CHECKS TESTS</h1>
        -> challengeCheckTests ->
        -> unitTests
    
    * [Effort Challenge Checks Tests]
        <h1>EFFORT CHALLENGE CHECKS TESTS</h1>
        -> challengeCheckWithEffortTests ->
        -> unitTests
    
    * [Finish Tests]
        -> END
