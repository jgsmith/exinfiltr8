#
# stuff around buying
#

reacts to resource:chits:decrement as buyer with do
  if cost <= resource:chits then
    set resource:chits to resource:chits - cost
  else
    set resource:chits to 0
  end
end

can buy:item as actor

reacts to pre-buy:item as actor with do
  :"<Actor> <offer> to buy {{ item }} from <direct>."
end