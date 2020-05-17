defmodule Archetypes.VendorTest do
  use Exinfiltr8.DataCase, async: false

  alias Militerm.Test.Entity

  setup do
    char_data = %{
      "gender" => "neuter",
      "name" => "character",
      "cap_name" => "Character"
    }

    entity = Entity.new(char_data)

    {:ok, entity: entity}
  end

  describe "buy drink from bartender" do
    @tag diegetic: true
    test "buys", %{entity: entity} do
      assert Entity.property(entity, "resource:chits") == 50

      entity
      |> Entity.send_input("go east")
      |> Entity.send_input("go north")
      |> Entity.send_input("stand at the bar")
      |> Entity.send_input("tell the bartender I want to buy an ale")
      |> Entity.await_event("post-resource:chits:decrement")

      assert Entity.property(entity, "resource:chits") == 49
    end
  end
end
