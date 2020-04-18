can go as actor

reacts to pre-enter:item as actor with do
  if direct.detail:default:enter:target then
    set eflag:entering
    if is standing then
      :"<Actor> <enter> <direct>."
    else
      :"<Actor> <crawl> in <direct>."
    end
  else
    uhoh "You can't go that way."
  end
end

reacts to enter:item as actor with do
  if eflag:entering then
    if not MoveTo("normal", "in", direct.detail:default:enter ) then
      reset eflag:entering
      uhoh "You can't go that way."
    end
  end
end

reacts to post-enter:item as actor with do
  if eflag:entering then
    if is standing then
      :"<Actor> <walk> in."
    else
      :"<Actor> <crawl> in."
    end
    reset eflag:entering
  end
end