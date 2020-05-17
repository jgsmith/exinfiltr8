###
# positioning
#

can sit as actor
can stand as actor
can kneel as actor
can crouch as actor

is standing if location:position = "standing"
is kneeling if location:position = "kneeling"
is sitting if location:position = "sitting"
is crouching if location:position = "crouching"

validates location:position with
  if value & trait:allowed:positions then
    True
  else
    False
  end

calculates trait:allowed:positions with do
  if location:location.detail:default:allowed-positions then
    location:location.detail:default:allowed-positions & ([ "standing", "sitting", "kneeling", "crouching" ])
  else
    ([ "standing", "sitting", "kneeling", "crouching" ])
  end
end

reacts to change:location:position as observed with
  if value = "standing" then
    :"<This:name> <stand> up."
  elsif value = "sitting" then
    :"<This:name> <sit> down."
  elsif value = "crouching" then
    :"<This:name> <crouch> down."
  elsif value = "kneeling" then
    :"<This:name> <kneel> down."
  end

reacts to pre-sit as actor with
  if is sitting then
    uhoh "You are already sitting."
  else
    if "sitting" & trait:allowed:positions then
      set eflag:is-about-to-sit
    else
      uhoh "You can't sit there."
    end
  end

reacts to pre-sit:maybe as actor with
  if is not sitting then
    if "sitting" & trait:allowed:positions then
      set eflag:is-about-to-sit
    else
      uhoh "You can't sit there."
    end
  end

reacts to post-sit as actor with
  if eflag:is-about-to-sit then
    reset eflag:is-about-to-sit
    set location:position to "sitting"
  end

reacts to pre-crouch as actor with
  if is crouching then
    uhoh "You are already crouching."
  else
    if "crouching" & trait:allowed:positions then
      set eflag:is-about-to-crouch
    else
      uhoh "You can't crouch there."
    end
  end

reacts to pre-crouch:maybe as actor with
  if is not crouching then
    if "crouching" & trait:allowed:positions then
      set eflag:is-about-to-crouch
    else
      uhoh "You can't crouch there."
    end
  end

reacts to post-crouch as actor with
  if eflag:is-about-to-crouch then
    reset eflag:is-about-to-crouch
    set location:position to "crouching"
  end

reacts to pre-kneel as actor with
  if is kneeling then
    uhoh "You are already kneeling."
  else
    if "kneeling" & trait:allowed:positions then
      set eflag:is-about-to-kneel
    else
      uhoh "You can't kneel there."
    end
  end

reacts to pre-kneel:maybe as actor with
  if is not kneeling then
    if "kneeling" & trait:allowed:positions then
      set eflag:is-about-to-kneel
    else
      uhoh "You can't kneel there."
    end
  end

reacts to post-kneel as actor with
  if eflag:is-about-to-kneel then
    reset eflag:is-about-to-kneel
    set location:position to "kneeling"
  end

reacts to pre-stand as actor with
  if is standing then
    uhoh "You are already standing."
  else
    if "standing" & trait:allowed:positions then
      set eflag:is-about-to-stand
    else
      uhoh "You can't stand there."
    end
  end

reacts to pre-stand:maybe as actor with
  if is not standing then
    if "standing" & trait:allowed:positions then
      set eflag:is-about-to-stand
    else
      uhoh "You can't stand there."
    end
  end
    
reacts to post-stand as actor with
  if eflag:is-about-to-stand then
    reset eflag:is-about-to-stand
    set location:position to "standing"
  end
