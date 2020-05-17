---
simple-response:
  vendor:
    - pattern: 
        - $_* list
        - $_* list $_*
      event: vendor:list
    - pattern:
        - $_* sell me $item+
        - $_* sell $item+ to me
        - $_* buy $item+
      event: vendor:buy
---
based on std:npc

is selling

can tell:normal as direct

reacts to pre-tell:normal as direct with True

reacts to post-tell:normal as direct with do
  if not SimpleResponseTriggerEvent("vendor", message) then 
    :"<This> <say>: <Actor:name>, I don't understand what you want."
  end
end