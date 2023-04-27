INCLUDE tricube-tales-system.ink

// character data

LIST characterTrait = agile, brawny, crafty
LIST characterConcept = samurai, hustler, thief, hacker, techie, wheelperson, saboteur
LIST characterPerk = cyberarm, boosted_reflexes, smartgun, custom_cyberdeck, microdrones, full_spectrum_vision, retractable_claws
LIST characterQuirk = inquisitive, cynical, obnoxious, foolhardy, brooding, callous, gloryhound


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
        ~ return "Glory-Seeking"
    - else:
        ~ return "!! Unknown Quirks !!"
    }

=== function printCharacterDescription()
    You are a{characterTrait == agile :n} { getCharacterTraitDescription(characterTrait) } {getCharacterConceptDescription(characterConcept)} with {getCharacterPerkDescription(characterPerk)}. {~Your friends agree|Your enemies all say|You've been told|Some say} your {getCharacterQuirkDescription(characterQuirk)} {~approach|personality|style} can {~make working with you difficult|be grating|lead to surprises}.
    
    ~ return
  

=== characterCreation ===
Welcome to the Chrome Shells & Neon Streets demo, made in Inky!

We should put the one-pager introduction, if we share this with other people. I'm cutting corners, though!

-> pickCharacterCreationType

= pickCharacterCreationType
How do you want to make your character?
    + [Randomly generate my character.]
        -> doRandomGeneration
    + [Allow me to create my character, please.]
        -> doCharacterConfiguration

= doRandomGeneration
~ makeRandomCharacter()
~ printCharacterDescription()

Is that correct?
    * * [Yes]
        ->->
    + + [No]
        Okay... <>
        -> pickCharacterCreationType

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
+ [Glory-seeking]
    ~ characterQuirk = gloryhound
    -> verifyPlayerChoices

= verifyPlayerChoices
If I've got this right... <>
~ printCharacterDescription()

Is that correct?
    * * [Yes]
        ->->
    + + [No]
        Okay... <>
        -> pickCharacterCreationType
