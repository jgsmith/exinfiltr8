defmodule Verbs.DropTest do
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

    Militerm.Services.Location.place(item, {"in", entity})

    {:ok, entity: entity, item: item}
  end

  describe "drop item" do
    @tag diegetic: true
    test "drops", %{entity: entity, item: item} do
      assert Entity.environment(item) == entity

      entity
      |> Entity.send_command("drop item")

      assert Entity.environment(item) == entity
      assert Entity.proximity(item) == "near"

      prior_location = Entity.location(entity)
      prior_prox = Entity.proximity(entity)

      entity
      |> Entity.send_command("go east")

      assert Entity.location(item) == prior_location
      assert Entity.proximity(item) == prior_prox
    end
  end
end
