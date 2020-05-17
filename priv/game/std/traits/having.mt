calculates thing:inventory with do
  selecting Inventory() as $thing with do
    (this = $thing.location:environment) and ($thing.location:proximity & ([ "in", "worn by", "held by" ]))
  end
end

reacts to pre-move:receive as environment with
  True

reacts to pre-move:release as environment with
  True
