---
---
is movable, viewable, readable, gettable, droppable, having

can scan:item as direct
can move as direct
can move:accept as direct

reacts to object:destroy as object with
  Destroy()

calculates counter:light with
  counter:light:mine + mapping thing:inventory as $thing with 
    $thing.counter:light

calculates counter:light:mine with
  if flag:provides-light then
    1
  else
    0
  end