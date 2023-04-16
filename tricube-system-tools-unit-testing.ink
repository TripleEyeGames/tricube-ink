INCLUDE tricube-system-tools.ink

// these list is part of the character definition for your story
// we need to add it here to test the core functions
LIST characterTrait = trait1, trait2, trait3
LIST characterConcept = concept1, concept2, concept3
LIST characterPerk = perk1, perk2, perk3
LIST characterQuirk = quirk1, quirk2, quirk3

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

=== karmaTests

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

=== offerToRecoverKarmaTests

    // skip - max difficulty
    ~ challengeDifficulty = MAX_DIFFICULTY
    ~ characterKarma = 1
    ~ characterQuirk = quirk1
    -> offerToRecoverKarma(challengeDifficulty, (quirk1)) ->
    offerToRecoverKarma - max difficulty skip - {challengeDifficulty == MAX_DIFFICULTY and characterKarma == 1:✔|<b>!!!</b>}

    // skip - no quirk
    ~ challengeDifficulty = 2
    ~ characterKarma = 1
    ~ characterQuirk = quirk2
    -> offerToRecoverKarma(challengeDifficulty, (quirk1)) ->
    offerToRecoverKarma - no quirk skip - {challengeDifficulty == 2 and characterKarma == 1:✔|<b>!!!</b>}

    // skip - max difficulty
    ~ challengeDifficulty = 2
    ~ characterKarma = MAX_KARMA
    ~ characterQuirk = quirk1
    -> offerToRecoverKarma(challengeDifficulty, (quirk1)) ->
    offerToRecoverKarma - max karma skip - {challengeDifficulty == 2 and characterKarma == MAX_KARMA:✔|<b>!!!</b>}

    // offer made
    ~ challengeDifficulty = 2
    ~ characterKarma = 2
    ~ characterQuirk = quirk1
    -> offerToRecoverKarma(challengeDifficulty, (quirk1)) ->
    offerToRecoverKarma - ^ there should be text displayed up here.

    ->->
    
=== unitTests ===
    // which test suite do you want to run?
    <h1> ROLL TESTS</h1>
    -> rollDiceTests ->
    
    <h1> ROLL RESOLUTION TESTS</h1>
    -> getRollResolutionRecursiveTests ->
    
    <h1> CHECK ROLL RESULTS TESTS</h1>
    -> checkRollResultsTests ->
    
    <h1> KARMA TESTS</h1>
    -> karmaTests ->
    
    <h1> RESOLVE TESTS</h1>
    -> resolveTests ->
    
    <h1>CHALLENGE TESTS</h1>
    -> offerToRecoverKarmaTests ->
    
    -> END
