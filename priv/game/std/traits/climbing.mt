can climb as actor

reacts to pre-climb:item:prox as actor with do
  set $prox to proximity
  
  if direct.detail:default:climbs:$prox:target then
    set eflag:moving
    set eflag:climbing
    if is standing then
      :"<Actor> <climb> " _ $prox _ " <direct>."
    else
      :"<Actor> <crawl> " _ $prox _ " <direct>."
    end
  else
    uhoh "You can't go that way."
  end
end

reacts to climb:item:prox as actor with do
  if eflag:climbing then
    set $prox to proximity
    if not MoveTo("normal", "in", direct.detail:default:climbs:$prox ) then
      reset eflag:climbing
      uhoh "You can't go that way."
    end
  end
end

reacts to post-climb:item:prox as actor with do
  if eflag:climbing then
    if is standing then
      :"<Actor> <walk> in."
    else
      :"<Actor> <crawl> in."
    end
    reset eflag:climbing
  end
end