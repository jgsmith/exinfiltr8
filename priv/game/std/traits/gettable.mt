#
# takable
#
# Can something be picked up?
#
can get:item as direct

reacts to pre-get:item as direct with do
  set eflag:moving
end

reacts to post-get:item as direct with do
  reset eflag:moving
end