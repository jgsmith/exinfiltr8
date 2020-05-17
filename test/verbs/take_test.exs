defmodule Verbs.TakeTest do
  use Exinfiltr8.DataCase, async: false

  alias Militerm.Test.Entity

  setup do
    data = %{
      "gender" => "neuter",
      "name" => "character",
      "cap_name" => "Character"
    }

    item_data = %{
      detail: %{
        "default" => %{
          "nouns" => ["thing", "item"]
        }
      }
    }

    item = Entity.new("std:thing", item_data)
    entity = Entity.new(data)

    entity_objs = %{"this" => entity}

    start_loc =
      {Militerm.Systems.Location.proximity(entity, entity_objs),
       Militerm.Systems.Location.location(entity, entity_objs)}

    Militerm.Services.Location.place(item, start_loc)

    {:ok, entity: entity, item: item}
  end

  describe "take item" do
    @tag diegetic: true
    test "takes", %{entity: entity, item: item} do
      assert Entity.environment(item) == Entity.environment(entity)

      entity
      |> Entity.send_command("take item")

      assert Entity.environment(item) == entity
      assert Entity.proximity(item) == "in"
    end
  end
end
