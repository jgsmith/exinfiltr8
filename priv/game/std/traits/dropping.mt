#
# Basic inventory
#

can drop:item as actor

reacts to pre-drop:item as actor with do
  if direct & thing:inventory then
    if direct.location:proximity = "worn by" then
      uhoh "You're wearing it!"
    else
      # remove counter info for holding
      set eflag:dropping-item
    end
  else
    uhoh "You don't have that!"
  end
end

reacts to drop:item as actor with do
  if eflag:dropping-item then
    set eflag:item-held to direct.location:proximity = "held by"
    if MoveTo("normal", direct, "near", this) then
      if eflag:item-held then
        set counter:holding to counter:holding - direct:counter:required-hands
        reset eflag:item-held
      end
      eflag:item-dropped
    end
  end
end

reacts to post-drop:item as actor with do
  if eflag:dropping-item then
    if eflag:item-dropped then
      if eflag:item-held then
        :"<Actor> <release> <actor:possessive> hold on <direct> and <drop> <direct:nominative>."
      else
        :"<Actor> <drop> <direct> nearby."
      end
    else
      :"<Actor> <try> to drop <direct> but <fail>."
    end
    reset eflag:dropping-item
    reset eflag:item-dropped
    reset eflag:item-held
  end
end