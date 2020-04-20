---
---
can open as actor
can close as actor

##
# We depend on the direct object doing the opening/closing on itself.
# This just narrates what the actor is doing.
#

reacts to pre-open as actor with do
  set eflag:opening
end

reacts to post-open as actor with do
  if eflag:opening then
    :"<Actor> <open> <direct>."
    reset eflag:opening
  end
end

reacts to pre-close as actor with do
  set eflag:closing
end

reacts to post-close as actor with do
  if eflag:closing then
    :"<Actor> <close> <direct>."
    reset eflag:closing
  end
end