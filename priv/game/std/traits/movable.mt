##
# moving around things in a scene
#

can move:accept:item as direct

reacts to pre-move:normal:item as direct with do
  True
end

reacts to move:normal:item as direct with do
  if eflag:moving then
    Place(moving_to)
  end
end

reacts to post-move:accept:item as direct with do
  if physical:location.detail:default:default-position and not (physical:position & trait:allowed:positions) then
    set physical:position to physical:location.detail:default:default-position
  end
end

reacts to pre-move:accept:item as direct with do
  True
end