defmodule Verbs.LightTest do
  use Exinfiltr8.DataCase, async: false

  alias Militerm.Test.Entity

  require Logger

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

  describe "light item" do
    @tag diegetic: true
    test "lights", %{entity: entity, item: item} do
      assert Entity.environment(item) == entity
      assert Entity.is?(item, "fuelable") == true
      assert Entity.is?(item, "fueled") == true
      assert Entity.is?(item, "burning") == false

      entity
      |> Entity.send_command("light item")

      assert Entity.is?(item, "burning") == true
    end

    test "lights a room", %{entity: entity, item: item} do
      crawlspace = {:thing, "scene:well:infrared:pantry-crawlspace", "default"}
      Militerm.Systems.Entity.whereis(crawlspace)

      Militerm.Services.Location.place(entity, {"in", crawlspace})
      assert Entity.is?(crawlspace, "scene") == true
      assert Entity.is?(crawlspace, "dark") == true

      entity
      |> Entity.send_command("light item")

      Logger.debug("-------------------- item burning? -----------------------")
      assert Entity.is?(item, "burning") == true
      Logger.debug("--------------- item counter:light:mine ------------------")
      assert Entity.property(item, "counter:light:mine") == 1
      Logger.debug("------------------ item counter:light --------------------")
      assert Entity.property(item, "counter:light") == 1
      Logger.debug("----------------- entity counter:light -------------------")
      assert Entity.property(entity, "counter:light") == 1
      Logger.debug("----------------- scene counter:light --------------------")
      assert Entity.property(crawlspace, "counter:light") == 1

      assert Entity.is?(crawlspace, "dark") == false
    end
  end
end
