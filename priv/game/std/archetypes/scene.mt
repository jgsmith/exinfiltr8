---
---
based on std:thing

##
# Marks the entity as a scene
is scene

is openable-doors

can move:receive as environment
can move:release as environment

can enter:item as direct if direct.detail:default:enter:target
can climb:item as direct if direct.detail:default:climbs