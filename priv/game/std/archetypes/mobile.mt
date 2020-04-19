---
resource:
  chits: 0
  dollars: 0
  health: 100
stat:
  intelligence: 10
  perception: 10
  constitution: 10
  strength: 10
---
based on std:thing

is leveling, sentient

is going, walking, positioning, entering, moving

can move:accept as actor

can enter:item as actor

reacts to pre-move:accept with do
  # TODO: check that there is a valid position the character can take when
  #       it gets to the destination
  True
end

reacts to move:normal as actor with do
  if eflag:moving then
    Place(moving_to)
  end
end

reacts to post-move:accept with
  if physical:location.detail:default:position and not (physical:position & trait:allowed:positions) then
    set physical:position to physical:location.detail:default:position
  end

reacts to pre-move:elevator as direct with do
  if location:environment is elevator then
    :"The lift whisks <this> away."
    set eflag:moving
    set eflag:via-elevator
  else
    uhoh "You have to be in a lift!"
  end
end

reacts to move:elevator as direct with do
  if eflag:moving then
    Place(moving_to)
  end
end

reacts to post-move:elevator as direct with do
  reset eflag:moving
  if eflag:via-elevator then
    reset eflag:via-elevator
    :"<This> <fly> into the lift."
  end
end