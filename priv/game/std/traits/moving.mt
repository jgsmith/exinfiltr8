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

reacts to pre-move:at as actor with do
  if "at" & direct.detail:default:proximities then
    set eflag:moving
    set eflag:moving-at
  else
    [ <- move:to as actor with direct: direct ]
  end
end

reacts to move:at as actor with do
  if eflag:moving-at then
    if is standing then
      :"<Actor> <move> to <direct>."
    else
      :"<Actor> <crawl> to <direct>."
    end
    if not MoveTo("normal", "at", direct) then
      reset eflag:moving
      reset eflag:moving-behind
      uhoh "You can't move there!"
    end
    reset eflag:moving
    reset eflag:moving-to
  end
end

reacts to pre-move:behind as actor with do
  if "behind" & direct.detail:default:proximities then
    set eflag:moving
    set eflag:moving-behind
  else
    uhoh "You can't move behind that!"
  end
end

reacts to move:behind as actor with do
  if eflag:moving-behind then
    if is standing then
      :"<Actor> <move> behind <direct>."
    else
      :"<Actor> <crawl> behind <direct>."
    end
    if not MoveTo("normal", "behind", direct) then
      reset eflag:moving
      reset eflag:moving-behind
      uhoh "You can't move behind there!"
    end
    reset eflag:moving
    reset eflag:moving-behind
  end
end

reacts to pre-move:on as actor with do
  if "on" & direct.detail:default:proximities then
    set eflag:moving
    set eflag:moving-on
  else
    uhoh "You can't move onto that!"
  end
end

reacts to move:on as actor with do
  if eflag:moving-on then
    if is standing then
      :"<Actor> <move> onto <direct>."
    else
      :"<Actor> <crawl> onto <direct>."
    end
    if not MoveTo("normal", "on", direct) then
      reset eflag:moving
      reset eflag:moving-on
      uhoh "You can't move onto there!"
    end
    reset eflag:moving
    reset eflag:moving-on
  end
end