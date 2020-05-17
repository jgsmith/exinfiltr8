---
---
can light as actor
can extinguish as actor

reacts to pre-light:item as actor with do
  set eflag:lighting-item
end

reacts to post-light:item as actor with do
  if eflag:lighting-item then
    reset eflag:lighting-item
    :"<Actor> <light> <direct>."
  end
end

reacts to pre-extinguish:item as actor with do
  set eflag:extinguishing-item
end

reacts to post-extinguish:item as actor with do
  if eflag:extinguish-item then
    reset eflag:extinguish-item
    :"<Actor> <extinguish> <direct>."
  end
end