---
counter:
  wearing:
    head: 0
    neck: 0
    hands: 0
    wrists: 0
    fingers: 0
    legs: 0
    torso: 0
    feet: 0
    max:
      head: 1
      neck: 2
      hands: 1
      wrists: 2
      fingers: 10
      legs: 1
      torso: 1
      feet: 1
---
#
# allows a character to wear things
#

can wear:item as actor

#
# counter:wearing:$location - number of items at that location
# counter:wearing:max:$location - max. number of items at that location
# thing:worn:$location - items worn at that location
#
calculates thing:worn with do
  selecting Inventory() as $thing with do
    $thing.location:environment = this and
    $thing.location:proximity = "worn by"
  end
end

calculates thing:worn:head with do
  selecting Inventory() as $thing with do
    $thing.location:environment = this and
    $thing.location:proximity = "worn by"
    $thing.trait:worn-on = "head"
  end
end

calculates thing:worn:neck with do
  selecting Inventory() as $thing with do
    $thing.location:environment = this and
    $thing.location:proximity = "worn by"
    $thing.trait:worn-on = "neck"
  end
end

calculates thing:worn:hands with do
  selecting Inventory() as $thing with do
    $thing.location:environment = this and
    $thing.location:proximity = "worn by"
    $thing.trait:worn-on = "hands"
  end
end

calculates thing:worn:wrists with do
  selecting Inventory() as $thing with do
    $thing.location:environment = this and
    $thing.location:proximity = "worn by"
    $thing.trait:worn-on = "wrists"
  end
end

calculates thing:worn:fingers with do
  selecting Inventory() as $thing with do
    $thing.location:environment = this and
    $thing.location:proximity = "worn by"
    $thing.trait:worn-on = "fingers"
  end
end

calculates thing:worn:legs with do
  selecting Inventory() as $thing with do
    $thing.location:environment = this and
    $thing.location:proximity = "worn by"
    $thing.trait:worn-on = "legs"
  end
end

calculates thing:worn:torso with do
  selecting Inventory() as $thing with do
    $thing.location:environment = this and
    $thing.location:proximity = "worn by"
    $thing.trait:worn-on = "torso"
  end
end

calculates thing:worn:feet with do
  selecting Inventory() as $thing with do
    $thing.location:environment = this and
    $thing.location:proximity = "worn by"
    $thing.trait:worn-on = "feet"
  end
end

reacts to pre-wear:item as actor with do
  set $placement to direct.trait:worn-on

  if not direct is wearble then
    uhoh "You can't wear that!"
  elsif direct.location:environment <> this then
    uhoh "You don't have that!"
  elsif direct.location:environment = this and direct.location:proximity = "worn by" then
    uhoh "You're already wearing that!"
  elsif counter:wearing:$placement >= counter:wearing:max:$placement then
    uhoh "You can't wear anything more there!"
  else
    set eflag:wearing-item
  end
end

reacts to post-wear:item as actor with do
  if eflag:wearing-item then
    if MoveTo("normal", direct, "worn by", actor) then
      :"<Actor> <wear> <direct>."
      set $placement to direct.trait:worn-on
      set counter:wearing:$placement to counter:wearing:$placement + 1
    else
      :"<Actor> <try> to wear <direct> but <fail>."
    end
    reset eflag:wearing-item
  end
end

reacts to pre-remove:item as actor with do
  if direct.location:environment = this and direct.location:proximity = "worn by" then
    set eflag:removing-item
  else
    uhoh "You're not wearing that!"
  end
end

reacts to post-remove:item as actor with do
  if eflag:removing-item then
    if MoveTo("normal", direct, "in", actor) then
      :"<Actor> <remove> <direct>."
      set $placement to direct.trait:worn-on
      set counter:wearing:$placement to counter:wearing:$placement - 1
    else
      :"<Actor> <try> to remove <direct> but <fail>."
    end
    reset eflag:removing-item
  end
end