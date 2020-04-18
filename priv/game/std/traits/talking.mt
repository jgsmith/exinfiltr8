##
# talking
#
# Let's the entity speak. Reacting is handled elsewhere.
#

can say as actor
can whisper as actor
can shout as actor
can tell as actor

reacts to pre-say as actor with do
  set eflag:speaking
  set eflag:say-normal
end

reacts to post-say as actor with do
  if eflag:say-normal then
    reset eflag:speaking
    reset eflag:say-normal
    
    :"<Actor> <say> {{ message }}"
  end
end

reacts to pre-whisper as actor with do
  set eflag:speaking
  set eflag:say-whisper
end

reacts to post-whisper as actor with do
  if eflag:say-whisper then
    reset eflag:speaking
    reset eflag:say-whisper
    
    :"<Actor> <whisper> {{ message }}"@whisper
  end
end

reacts to pre-shout as actor  with do
  set eflag:speaking
  set eflag:say-shout
end

reacts to post-shout as actor with do
  if eflag:say-shout then
    reset eflag:speaking
    reset eflag:say-shout
    
    :"<Actor> <shout> {{ message }}"@shout
  end
end