---
counter:
  government:
    experience: 0
  resistance:
    experience: 0
    trust: 0
trait:
  government:
    trust: infrared
    levels:
      infrared:
        allowed: [infrared]
        next: red
        experience: 100
      red:
        allowed: [infrared, red]
        next: orange
        prev: infrared
        exprience: 200
      orange:
        allowed: [infrared, red, orange]
        next: yellow
        prev: red
        experience: 400
      yellow:
        allowed: [infrared, red, orange, yellow]
        next: green
        prev: orange
        experience: 800
      green:
        allowed: [infrared, red, orange, yellow, green]
        next: blue
        prev: yellow
        experience: 1600
      blue:
        allowed: [infrared, red, orange, yellow, green, blue]
        next: indigo
        prev: green
        experience: 3200
      indigo:
        allowed: [infrared, red, orange, yellow, green, blue, indigo]
        next: violet
        prev: indigo
        experience: 6400
      violet:
        allowed: [infrared, red, orange, yellow, green, blue, indigo, violet]
        next: ultraviolet
        prev: indigo
        experience: 12800
      ultraviolet:
        allowed: [infrared, red, orange, yellow, green, blue, indigo, violet, ultraviolet]
        prev: violet
---
calculates trait:allowed:levels with do
  set $level to trait:government:trust
  trait:government:levels:$level:allowed
end

calculates trait:previous:level with do
  set $level to trait:government:trust
  trait:government:levels:$level:prev
end

calculates trait:next:level with do
  set $level to trait:government:trust
  trait:government:levels:$level:next
end

calculates trait:next:level:experience with do
  set $level to trait:government:trust
  trait:government:levels:$level:experience
end