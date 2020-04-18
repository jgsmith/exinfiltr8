---
simple-response:
  lift:
    - pattern: $_* level $level
      event: elevator:request
    - pattern: $_* level $level $_*
      event: elevator:request
thing:
  lift:
    infrared:
      entity_id: "scene:well:infra:lift"
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

is elevator

reacts to say:normal as observer with do
  if not flag:responding-to-speach and coord = "default" then
    set flag:responding-to-speech
    if not SimpleResponseTriggerEvent("lift", message) then
      reset flag:responding-to-speech
    end
  end
  True
end

reacts to elevator:request as responder with do
  unset eflag:responding-to-speech
  set $level to level
  if thing:lift:$level and $level in actor.trait:allowed:levels then
    if level = trait:lift:level then
      :"<This> <say> you are already there: {{ level }} : " _ trait:lift:level _ "."
    else
      :"<This> <whisk> <actor> to their destination."
      MoveTo("lift", actor, "in", thing:lift:$level)
    end
  else
    :"<This> <say> {{level}} is not a valid level."
  end
end