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

reacts to pre-move:receive as environment with do
  HospitalPopulate()
  True
end

reacts to pre-move:release as environment with
  True

reacts to post-move:release as environment with do
  HospitalDepopulate()
end

is dark when flag:is-dark and (counter:light < 1)