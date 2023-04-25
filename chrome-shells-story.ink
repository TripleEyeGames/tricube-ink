INCLUDE chrome-shells-character.ink

LIST storyComplications = securityOnAlert

-> characterCreation ->
-> startTheJob

=== startTheJob ===
You have been hired to break into a “Haven Hosting” facility and steal a magical HAVEN figurine from the premises.
There are dozens of these locations scattered around the world, each built upon areas of natural magic to strengthen their enchantments and wards. Ostensibly, the facilities are designed to host and protect Haven’s computer servers—but top tier customers are also offered a safe deposit box service called the “Vault.”

-> attemptEntry

= attemptEntry
You can approach the facility in a variety of ways. Which do you want to try?
    * Stealth
        -> challengeCheck (5, characterTrait.agile, (thief, techie, saboteur), (boosted_reflexes), (gloryhound), -> failedEntry, -> failedEntry ) ->
        You've successfully snuck through security.
        -> welcome_inside
        
    * Brute Force
        -> challengeCheck (5, characterTrait.brawny, (samurai, wheelperson), (cyberarm), (foolhardy), -> failedEntry, -> failedEntry ) ->
        You've successfully crashed through security.
        -> welcome_inside

    * Deception
        -> challengeCheck (5, characterTrait.crafty, (hustler, hacker), (full_spectrum_vision), (inquisitive), -> failedEntry, -> failedEntry ) ->
        You've successfully talked your way through security.
        -> welcome_inside

= failedEntry
    You were not able to get in that way. Try again.
    -> attemptEntry
    
= welcome_inside
    Welcome inside!
    -> END
