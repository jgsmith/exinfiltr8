#
# Basic inventory
#

can get:item as actor

reacts to pre-get:item as actor with do
  if direct & thing:inventory then
    uhoh "You already have that!"
  elsif direct.location:environment = location:environment then
    set eflag:getting-item
  else
    uhoh "That's nowhere around here."
  end
end

reacts to get:item as actor with do
  if eflag:getting-item then
    if MoveTo("normal", direct, "in", this) then
      eflag:item-taken
    end
  end
end

reacts to post-get:item as actor with do
  if eflag:getting-item then
    if eflag:item-taken then
      :"<Actor> <get> <direct>."
    else
      :"<Actor> <try> to get <direct> but <fail>."
    end
    reset eflag:getting-item
    reset eflag:item-taken
  end
end