##
# talking
#
# Let's the entity speak. Reacting is handled elsewhere.
#

can say as actor
can tell as actor

reacts to pre-tell:normal as actor with do
  set eflag:speaking
  set eflag:tell-normal
end

reacts to post-tell:normal as actor with do
  if eflag:tell-normal then
    reset eflag:speaking
    reset eflag:tell-normal
    
    :"<Actor> <tell> <direct>: {{ message }}"
  end
end

reacts to pre-say:normal as actor with do
  set eflag:speaking
  set eflag:say-normal
end

reacts to post-say:normal as actor with do
  if eflag:say-normal then
    reset eflag:speaking
    reset eflag:say-normal
    
    :"<Actor> <say>: {{ message }}"
  end
end

reacts to pre-say:whisper as actor with do
  set eflag:speaking
  set eflag:say-whisper
end

reacts to post-say:whisper as actor with do
  if eflag:say-whisper then
    reset eflag:speaking
    reset eflag:say-whisper
    
    :"<Actor> <whisper>: {{ message }}"@whisper
  end
end

reacts to pre-say:shout as actor  with do
  set eflag:speaking
  set eflag:say-shout
end

reacts to post-say:shout as actor with do
  if eflag:say-shout then
    reset eflag:speaking
    reset eflag:say-shout
    
    :"<Actor> <shout>: {{ message }}"@shout
  end
end