#
# used by vendors to sell things
#

#
# trait:menu:$item:name
# trait:menu:$item:nouns
# trait:menu:$item:adjectives
# trait:menu:$item:cost
# trait:menu:$item:key
# trait:menu:items - list of $item keys

calculates trait:menu:item:names with do
  mapping trait:menu:items as $item with trait:menu:$item:name
end

can buy:item as direct

reacts to pre-buy:item as direct with True

reacts to post-buy:item as direct with do
  foreach trait:menu:items as $item with do
    if ParseMatchQ(item, trait:menu:$item:nouns, trait:menu:$item:adjectives) then
      set $selection to $item
    end
  end
  
  if $selection then
    if (trait:menu:$selection:cost) > (actor.resource:chits) then
      :"<This> <say>: I don't think you can afford that."
    else
      [ actor <- resource:chits:decrement as buyer with cost: trait:menu:$selection:cost ]
      $thing = HospitalCreate(trait:menu:$selection:type, trait:menu:$selection:key)
      if $thing then
        if MoveTo("normal", $thing, "in", actor) then
          :"<This> <sell> {{ $thing }} to <actor>."
        else
          :"<This> <say>: You dropped {{ $thing }}."
          MoveTo("normal", $thing, "near", actor)
        end
      end
    end
  else
    :"<This> <say>: I don't have anything like that."
  end
end

reacts to vendor:list as responder with do
  :"<This> <say>: I can offer you {{ ItemList( trait:menu:item:names ) }}."
end

# slots:
#   item - string indicating item
reacts to vendor:buy as responder with do
  foreach trait:menu:items as $item with do
    if ParseMatchQ(item, trait:menu:$item:nouns, trait:menu:$item:adjectives) then
      set $selection to $item
    end
  end
  
  if $selection then
    if (trait:menu:$selection:cost) > (actor.resource:chits) then
      :"<This> <say>: I don't think you can afford that."
    else
      [ actor <- resource:chits:decrement as buyer with cost: trait:menu:$selection:cost ]
      $thing = HospitalCreate(trait:menu:$selection:type, trait:menu:$selection:key)
      if $thing then
        if MoveTo("normal", $thing, "in", actor) then
          :"<This> <sell> {{ $thing }} to <actor>."
        else
          :"<This> <say>: You dropped {{ $thing }}."
          MoveTo("normal", $thing, "near", actor)
        end
      end
    end
  else
    :"<This> <say>: I don't have anything like that."
  end
end