#
# droppable
#
# Can something be dropped?
#
can drop:item as direct

reacts to pre-drop:item as direct with do
  set eflag:moving
  set eflag:dropping
end

reacts to post-drop:item as direct with do
  reset eflag:moving
  reset eflag:dropping
end