#
# viewing
#
# Allows a sentient to view their surroundings
#

can read:item as actor

##
# pre-scan:item
#
reacts to pre-read:item as actor with do
  if direct.detail:default:read then
    set eflag:read-item
    set eflag:reading
  else
    uhoh "There's nothing there to read!"
  end
end

reacts to post-read:item as actor with
  if eflag:read-item then
    :"<Actor:name> <read> <direct>."
    reset eflag:read-item
    reset eflag:reading
    Emit("{item sense='sight'}{{ direct.detail:default:read }}{/item}")
  end