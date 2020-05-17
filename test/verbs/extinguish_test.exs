defmodule Verbs.ExtinguishTest do
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
      },
      resource: %{
        "max-fuel" => 100,
        "fuel" => 100
      },
      flag: ["is-lightable"]
    }

    item = Entity.new("std:torch", item_data)
    entity = Entity.new(data)

    entity_objs = %{"this" => entity}

    Militerm.Services.Location.place(item, {"in", entity})

    {:ok, entity: entity, item: item}
  end

  describe "extinguish item" do
    @tag diegetic: true
    test "extinguishes a lit item", %{entity: entity, item: item} do
      assert Entity.environment(item) == entity
      assert Entity.is?(item, "fuelable") == true
      assert Entity.is?(item, "fueled") == true
      assert Entity.is?(item, "burning") == false

      entity
      |> Entity.send_command("light item")

      assert Entity.is?(item, "burning") == true

      entity
      |> Entity.send_command("extinguish item")

      assert Entity.is?(item, "burning") == false
    end
  end
end
