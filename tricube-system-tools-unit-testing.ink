INCLUDE tricube-system-tools.ink

// these list is part of the character definition for your story
// we need to add it here to test the core functions
LIST characterTrait = trait1, trait2, trait3
LIST characterConcept = concept1, concept2, concept3
LIST characterPerk = perk1, perk2, perk3
LIST characterQuirk = quirk1, quirk2, quirk3

LIST storyComplications = complication1, complication2, complication3

You Ready?
    * [Yeah, Let's go!]
        -> unitTests

// this function is part of the character definition for your story
// we need to add it here to test the core functions
=== function getCharacterPerkDescription(character_perk)
    ~ return character_perk

=== getRollResolutionRecursiveTests
    // crit fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1)
    getRollResolutionRecursive - Critical Failure - 1 die ({challengeDice}) vs 5: {getRollResolutionRecursive(d1, 5) == criticalFailure:✔|<b>!!!</b>}
    
    // fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_2)
    getRollResolutionRecursive - Failure - 1 die ({challengeDice}) vs 3: {getRollResolutionRecursive(d1, 3) == failure:✔|<b>!!!</b>}
    
    // fail
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_5)
    getRollResolutionRecursive - Failure - 1 die ({challengeDice}) vs 6: {getRollResolutionRecursive(d1, 6) == failure:✔|<b>!!!</b>}
    
    // success
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_2)
    getRollResolutionRecursive - Success - 1 die ({challengeDice}) vs 2: {getRollResolutionRecursive(d1, 2) == success:✔|<b>!!!</b>}
    
    // success
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_6)
    getRollResolutionRecursive - Success - 1 die ({challengeDice}) vs 6: {getRollResolutionRecursive(d1, 6) == success:✔|<b>!!!</b>}

    ->->

=== checkRollResultsTests
    // crit fail - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1)
    checkRollResults - Critical Failure - 1 die ({challengeDice}) vs 5: {checkRollResults(5) == criticalFailure:✔|<b>!!!</b>}
    
    // crit fail - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_1)
    checkRollResults - Critical Failure - 2 die ({challengeDice}) vs 5: {checkRollResults(5) == criticalFailure:✔|<b>!!!</b>}
    
    // crit fail - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_1, d3, d3_1)
    checkRollResults - Critical Failure - 3 die ({challengeDice}) vs 5: {checkRollResults(5) == criticalFailure:✔|<b>!!!</b>}
    
    // fail - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3)
    checkRollResults - Failure - 1 die ({challengeDice}) vs 5: {checkRollResults(5) == failure:✔|<b>!!!</b>}
    
    // fail - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3, d2, d2_4)
    checkRollResults - Failure - 2 die ({challengeDice}) vs 5: {checkRollResults(5) == failure:✔|<b>!!!</b>}
    
    // fail - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_2, d3, d3_3)
    checkRollResults - Failure - 3 die ({challengeDice}) vs 5: {checkRollResults(5) == failure:✔|<b>!!!</b>}
    
    // success - 1 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_5)
    checkRollResults - Success - 1 die ({challengeDice}) vs 5: {checkRollResults(5) == success:✔|<b>!!!</b>}
    
    // success - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_3, d2, d2_6)
    checkRollResults - Success - 2 die ({challengeDice}) vs 5: {checkRollResults(5) == success:✔|<b>!!!</b>}
    
    // success - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_2, d3, d3_6)
    checkRollResults - Success - 3 die ({challengeDice}) vs 5: {checkRollResults(5) == success:✔|<b>!!!</b>}
    
    // exceptional success - 2 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_6, d2, d2_6)
    checkRollResults - Exceptional Success - 2 die ({challengeDice}) vs 5: {checkRollResults(5) == exceptionalSuccess:✔|<b>!!!</b>}
    
    // exceptional success - 3 die
    ~ challengeDice = ()
    ~ challengeDice += (d1, d1_1, d2, d2_5, d3, d3_6)
    checkRollResults - Exceptional Success - 3 die ({challengeDice}) vs 5: {checkRollResults(5) == exceptionalSuccess:✔|<b>!!!</b>}
    
    ->->

=== rollDiceTests
    
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
- These tests need to be run manually:
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
        ~ challengeDifficulty = 2
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
        ~ challengeDifficulty = 2
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
        ~ challengeDifficulty = 2
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
        ~ challengeDifficulty = 2
        ~ challengeDifficultyModifier = 0
        ~ challengeQuirkPayout = ()
    
        ~ characterKarma = MAX_KARMA
        ~ characterResolve = 2
        ~ characterQuirk = quirk1
        
        offerToApplyQuirkToChallengeRoll - resolve offer made - please pick +1 Resolve
        -> offerToApplyQuirkToChallengeRoll((quirk1)) ->
        offerToApplyQuirkToChallengeRoll - quirk offer accepted - {challengeDifficultyModifier == 1 and challengeQuirkPayout == resolve:✔|<b>!!!</b>}
        
        -> offerToApplyQuirkOnChallengeRollTestsLoop

    * [Finish Quirk Tests]
        ->->

=== offerToApplyComplicationTests
- These tests need to be run manually:
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
    
    * [Finish Complications Tests]
        ->->

=== challengeCheckTests
- These tests need to be run manually:
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

    + [1 Die, 2 Difficulty, No Perk Match]
        challengeCheck(2) <>
        -> challengeCheck (2, (), (), (), (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 3 Difficulty, No Perk Match]
        challengeCheck(3) <>
        -> challengeCheck (3, (), (), (), (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 4 Difficulty, No Perk Match]
        challengeCheck(4) <>
        -> challengeCheck (4, (), (), (), (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 5 Difficulty, No Perk Match]
        challengeCheck(5) <>
        -> challengeCheck (5, (), (), (), (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 6 Difficulty, No Perk Match]
        challengeCheck(6) <>
        -> challengeCheck (6, (), (), (), (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 2 Difficulty, Perk Match]
        challengeCheck(2) <>
        -> challengeCheck (2, (), (), perk1, (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 3 Difficulty, Perk Match]
        challengeCheck(3) <>
        -> challengeCheck (3, (), (), perk1, (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 4 Difficulty, Perk Match]
        challengeCheck(4) <>
        -> challengeCheck (4, (), (), perk1, (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 5 Difficulty, Perk Match]
        challengeCheck(5) <>
        -> challengeCheck (5, (), (), perk1, (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    + [1 Die, 6 Difficulty, Perk Match]
        challengeCheck(6) <>
        -> challengeCheck (6, (), (), perk1, (), -> challengeCheckTestsFailure, -> challengeCheckTestsFailure) ->
        
        The challenge succeeded!
        -> challengeCheckTestsLoop

    * [Finish Challenge Check Tests]
        ->->

=== challengeCheckTestsFailure
    The challenge failed.
    -> challengeCheckTestsLoop

=== unitTests ===
    // which test suite do you want to run?
    <h1>ROLL TESTS</h1>
    -> rollDiceTests ->
    
    <h1>ROLL RESOLUTION TESTS</h1>
    -> getRollResolutionRecursiveTests ->
    
    <h1>CHECK ROLL RESULTS TESTS</h1>
    -> checkRollResultsTests ->
    
    <h1>USE KARMA TESTS</h1>
    -> useKarmaTests ->
    
    <h1>RESOLVE TESTS</h1>
    -> resolveTests ->
    
    <h1>APPLY QUIRK TESTS</h1>
    -> offerToApplyQuirkOnChallengeRollTests ->
    
    <h1>APPLY COMPLICATIONS TESTS</h1>
    -> offerToApplyComplicationTests ->
    
    <h1>CHALLENGE CHECKS</h1>
    -> challengeCheckTests ->
    
    -> END
