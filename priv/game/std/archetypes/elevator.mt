---
simple-response:
  lift:
    - pattern: 
        - $_* level $level
        - $_* level $level $_*
      event: elevator:request
thing:
  lift:
    infrared:
      entity_id: "scene:well:infrared:lift"
      coord: floor
    red:
      entity_id: "scene:well:red:lift"
      coord: floor
    orange:
      entity_id: "scene:well:orange:lift"
      coord: floor
    yellow:
      entity_id: "scene:well:yellow:lift"
      coord: floor
    green:
      entity_id: "scene:well:green:lift"
      coord: floor
    blue:
      entity_id: "scene:well:blue:lift"
      coord: floor
    indigo:
      entity_id: "scene:well:indigo:lift"
      coord: floor
    violet:
      entity_id: "scene:well:violet:lift"
      coord: floor
    ultraviolet:
      entity_id: "scene:well:ultraviolet:lift"
      coord: floor
---
based on std:scene

is elevator, talking

can move:elevator as actor

reacts to post-say:normal as observer with do
  if coord = "default" then
    if trait:lift:level & actor.trait:allowed:levels then
      if not eflag:responding-to-speach then
        set eflag:responding-to-speech
        if not SimpleResponseTriggerEvent("lift", message) then
          reset eflag:responding-to-speech
        end
      end
    else
      unset eflag:responding-to-speech
      :"<This> <say>: <actor>, you are not allowed here!"
      :"<This> <say>: This will be reported to the authorities."
      [ actor <- government:experience:decrement as target with amount: 50 ]
      set $level to actor.trait:government:trust
      MoveTo("elevator", actor, "on", thing:lift:$level)
    end
  end
  True
end

reacts to elevator:request as responder with do
  unset eflag:responding-to-speech
  set $level to level
  if thing:lift:$level and $level & actor.trait:allowed:levels then
    if level = trait:lift:level then
      # [ <- say:normal as actor with actor: this, message: "you are already there" ]
      :"<This> <say>: you are already there."
    else
      :"<This> <whisk> <actor> to their destination."
      MoveTo("elevator", actor, "in", thing:lift:$level)
    end
  else
    # [ <- say:normal as actor with actor: this, message: (level _ " is not a valid level") ]
    :"<This> <say>: {{level}} is not a valid level."
  end
end