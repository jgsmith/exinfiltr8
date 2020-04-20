---
---

##
# doors are guarded exits that have a state in two different scenes
#
# The open/closed state of the door is in flag:doors:$coord:opened
#   It's coordinated with the target/coord of the thing:door:links:$coord
#     property
#

can open as direct
can close as direct

reacts to pre-open as direct with do
  set $coord to coord

  if detail:$coord:door then
    if flag:doors:$coord:opened then
      uhoh "It's already open!"
    else
      # don't worry about locks/keys for now
      [ <- local:open:door as direct with actor: actor, direct: direct, coord: coord]
      if thing:door:links:$coord then
        [ thing:door:links:$coord <- local:open:door as direct with actor: actor, direct: direct ]
      end
    end
  else
    uhoh "That's not a door!"
  end
end

reacts to pre-local:open:door as direct with do
  set $coord to coord
  
  set eflag:opening:door:$coord
  set eflag:opening-doors
end

reacts to post-local:open:door as direct with do
  if eflag:opening-doors then
    set $coord to coord
    set flag:doors:$coord:opened
    :"<This> <open>."
    set detail:$coord:state to "It is open."
    reset eflag:opening-doors
    reset eflag:opening:door:$coord
  end
end

reacts to pre-close as direct with do
  set $coord to coord

  if flag:doors:$coord:door then
    if not flag:doors:$coord:opened then
      uhoh "It's already closed!"
    else
      # don't worry about locks/keys for now
      [ <- local:close:door as direct with actor: actor, direct: direct, coord: coord]
      if thing:door:links:$coord then
        [ thing:door:links:$coord <- local:close:door as direct with actor: actor, direct: direct ]
      end
    end
  else
    uhoh "That's not a door!"
  end
end

reacts to pre-local:close:door as direct with do
  set $coord to coord
  
  set eflag:closing:door:$coord
  set eflag:closing-doors
end

reacts to post-local:open:door as direct with do
  if eflag:closing-doors then
    set $coord to coord
    reset flag:doors:$coord:opened
    :"<This> <close>."
    set detail:$coord:state to "It is closed."
    reset eflag:closing:door:$coord
    reset eflag:closing-doors
  end
end