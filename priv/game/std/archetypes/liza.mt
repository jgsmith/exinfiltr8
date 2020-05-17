---
simple-response:
  greeting:
    - pattern: $_* hello $_*
      event: basic:greeting
  basic:
    - pattern: $_* computer $_*
      event: basic:computer
    - pattern: $_* name $_*
      event: basic:name
    - 
---
based on std:npc

reacts to post-say:normal as observer with do
  if not eflag:responding-to-speach then
    set eflag:responding-to-speech
    set $actor_id to Id(actor)
    set $state to trait:liza:player:$id:state // "greeting"
    if not SimpleResponseTriggerEvent($state, message) then
      [ <- unrecognized:$state as responder with actor: actor ]
    end
    reset eflag:responding-to-speech
  end
end

reacts to unrecognized:greeting as responder with do
  set response to RandomSelection( ({
    "Who are you?",
    "Can't find the time to say hello?"
  }) )
  :"<This> <say>: {{ response }}"
end

###
# Provides a simple chatbot based on the Eliza program
#
reacts to greeting as responder with do
  set $actor_id to Id(actor)
  set trait:liza:player:$id:state to "basic"
  
  :"<This> <say>: How do you do. Please state your problem."
end

reacts to basic:computer as responder with do
  set response to RandomSelection( ({
      "Do computers worry you?",
      "What do you think about machines?",
      "Why do you mention computers?",
      "What do you think machines have to do with your problem?"
  }) )
  
  :"<This> <say>: {{ response }}"
end

reacts to basic:name as responder with do
  :"<This> <say>: I am not interested in names."
end