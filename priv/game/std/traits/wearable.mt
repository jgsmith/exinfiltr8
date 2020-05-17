#
# allows a thing to be worn by a character
#

# it has to have a location where it can be worn
is wearable if trait:worn-on
is worn if location:proximity = "worn by"

can wear:item as direct if is wearable

reacts to pre-wear:item as direct with do
  True
end