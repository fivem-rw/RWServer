PLAYER_GROUP = GetHashKey("PLAYER")

ZOMBIE_PLAYER_GROUP = GetHashKey("_ZOMBIE_PLAYER")
AddRelationshipGroup("_ZOMBIE_PLAYER")
SetRelationshipBetweenGroups(5, PLAYER_GROUP, ZOMBIE_PLAYER_GROUP)
SetRelationshipBetweenGroups(5, ZOMBIE_PLAYER_GROUP, PLAYER_GROUP)

ZOMBIE_GROUP1 = GetHashKey("_ZOMBIE1")
AddRelationshipGroup("_ZOMBIE1")
SetRelationshipBetweenGroups(5, PLAYER_GROUP, ZOMBIE_GROUP1)
SetRelationshipBetweenGroups(5, ZOMBIE_GROUP1, PLAYER_GROUP)

ZOMBIE_GROUP1_BOSS = GetHashKey("_ZOMBIE1_BOSS")
AddRelationshipGroup("_ZOMBIE1_BOSS")
SetRelationshipBetweenGroups(5, PLAYER_GROUP, ZOMBIE_GROUP1_BOSS)
SetRelationshipBetweenGroups(5, ZOMBIE_GROUP1_BOSS, PLAYER_GROUP)

ZOMBIE_GROUP2 = GetHashKey("_ZOMBIE2")
AddRelationshipGroup("_ZOMBIE2")
SetRelationshipBetweenGroups(5, PLAYER_GROUP, ZOMBIE_GROUP2)
SetRelationshipBetweenGroups(5, ZOMBIE_GROUP2, PLAYER_GROUP)

ZOMBIE_GROUP2_BOSS = GetHashKey("_ZOMBIE2_BOSS")
AddRelationshipGroup("_ZOMBIE2_BOSS")
SetRelationshipBetweenGroups(5, PLAYER_GROUP, ZOMBIE_GROUP2_BOSS)
SetRelationshipBetweenGroups(5, ZOMBIE_GROUP2_BOSS, PLAYER_GROUP)

ZOMBIE_GROUP3 = GetHashKey("_ZOMBIE3")
AddRelationshipGroup("_ZOMBIE3")
SetRelationshipBetweenGroups(5, PLAYER_GROUP, ZOMBIE_GROUP3)
SetRelationshipBetweenGroups(5, ZOMBIE_GROUP3, PLAYER_GROUP)

ZOMBIE_GROUP3_BOSS = GetHashKey("_ZOMBIE3_BOSS")
AddRelationshipGroup("_ZOMBIE3_BOSS")
SetRelationshipBetweenGroups(5, PLAYER_GROUP, ZOMBIE_GROUP3_BOSS)
SetRelationshipBetweenGroups(5, ZOMBIE_GROUP3_BOSS, PLAYER_GROUP)

SAFEZONE_GUARD_GROUP = GetHashKey("_SAFEZONE_GUARD")
AddRelationshipGroup("_SAFEZONE_GUARD")
SetRelationshipBetweenGroups(1, PLAYER_GROUP, SAFEZONE_GUARD_GROUP)
SetRelationshipBetweenGroups(1, SAFEZONE_GUARD_GROUP, PLAYER_GROUP)