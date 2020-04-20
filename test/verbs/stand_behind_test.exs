defmodule Verbs.StandBehindTest do
  use Exinfiltr8.DataCase, async: false

  alias Militerm.Test.Entity

  setup do
    data = %{
      "gender" => "neuter",
      "name" => "character",
      "cap_name" => "Character"
    }

    {:ok, entity: Entity.new(data)}
  end

  describe "stand behind bar" do
    @tag diegetic: true
    test "moves", %{entity: entity} do
      entity
      |> Entity.send_command("go east")
      |> Entity.send_input("go north")
      |> Entity.send_input("stand behind the bar")

      assert Entity.location(entity) == {:thing, "scene:well:infrared:doggin-pony", "bartop"}
      assert Entity.proximity(entity) == "behind"
    end
  end
end
