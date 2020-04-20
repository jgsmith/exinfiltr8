##
# moving around things in a scene
#

can move as actor

reacts to pre-move:to as actor with do
  if direct.detail:default:default-proximity then
    set eflag:moving
    set eflag:moving-to
  else
    uhoh "You can't move there."
  end
end

reacts to move:to as actor with do
  if eflag:moving-to then
    if is standing then
      :"<Actor> <move> to <direct>."
    else
      :"<Actor> <crawl> to <direct>."
    end
    set $prox to direct.detail:default:default-proximity
    if not MoveTo("normal", $prox, direct) then
      reset eflag:moving
      reset eflag:moving-to
      uhoh "You can't move behind there!"
    end
    reset eflag:moving
    reset eflag:moving-to
  end
end

reacts to pre-move:prox as actor with do
  if not proximity & direct.detail:default:proximities then
    [ <- move:to as actor with direct: direct ]
  else
    set eflag:moving
    set eflag:moving-prox
  end
end

reacts to move:prox as actor with do
  set $prep to proximity
  
  if proximity = "at" then
    set $prep to "to"
  elsif proximity = "on" then
    set $prep to "onto"
  elsif proximity = "onto" or proximity = "on to" then
    set $prep to "onto"
    set proximity to "on"
  end
  
  if eflag:moving-prox then
    if is standing then
      :"<Actor> <move> " _ $prep _ " <direct>."
    else
      :"<Actor> <crawl> " _ $prep _ " <direct>."
    end
    if not MoveTo("normal", proximity, direct) then
      reset eflag:moving
      reset eflag:moving-prox
      uhoh "You can't move there!"
    end
    reset eflag:moving
    reset eflag:moving-prox
  end
end