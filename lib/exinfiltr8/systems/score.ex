defmodule Exinfiltr8.Systems.Score do
  use Militerm.ECS.System

  alias Militerm.Systems.Entity

  defcommand score(_), for: %{"this" => this} = objects do
    glevel = Entity.property(this, ~w[trait government trust], objects)
    rlevel = Entity.property(this, ~w[counter resistance trust], objects)

    Entity.receive_message(this, "cmd", "Your government trust level: #{glevel}", %{})
    Entity.receive_message(this, "cmd", "Your resistance trust level: #{rlevel}", %{})
  end
end
