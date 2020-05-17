---
resource:
  fuel: 0
  max-fuel: 0
flag:
  - torch:not-is-burning
  - not-is-lightable
---

is fuelable if resource:max-fuel > 0
is fueled if resource:fuel > 0
is burning if flag:torch:is-burning

calculates flag:provides-light with
  is burning

calculates trait:lit:description with do
  if is burning then
    "It is lit."
  else
    "It is not lit."
  end
end

can light as direct 
#if is fueled and is not burning
can extinguish as direct 
#if is burning

reacts to change:flag:torch:is-burning with do
  if value then
    :"<This> <light> up."
  else
    :"<This> <grow> dark as the flame dies out."
  end
end

reacts to pre-light:item as direct with do
  if is fueled and is not burning then
    set eflag:lighting-torch
  else
    uhoh "That won't light!"
  end
end

reacts to post-light:item as direct with do
  if eflag:lighting-torch then
    set flag:torch:is-burning
    set trait:timers:consume_fuel_id to Every("consume:fuel", 1)
    reset eflag:lighting-torch
  end
end

reacts to pre-extinguish:item as direct with do
  if is burning then
    set eflag:extinguishing-torch
  else
    uhoh "That isn't lit!"
  end
end

reacts to post-extinguish:item as direct with do
  if eflag:extinguishing-torch then
    reset flag:torch:is-burning
    StopTimer(trait:timers:consume_fuel_id)
    reset eflag:extinguishing-torch
  end
end

reacts to timer:consume:fuel as timer with do
  if is burning and is fueled then
    set resource:fuel to resource:fuel - 1
    if resource:fuel = 10 then
      :"<This> <sputter> a bit."
    end
  else
    reset flag:torch:is-burning
    StopTimer(trait:timers:consume_fuel_id)
  end
end