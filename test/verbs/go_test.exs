defmodule Verbs.GoTest do
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

  describe "go east" do
    @tag diegetic: true
    test "moves", %{entity: entity} do
      entity
      |> Entity.send_input("go east")

      assert Entity.location(entity) == {:thing, "scene:well:infrared:east-corridor-1", "floor"}
    end
  end

  describe "goes around the ring" do
    @tag diegetic: true
    test "moves", %{entity: entity} do
      entity
      # to east-corridor-1
      |> Entity.send_input("go east")
      # to east-corridor-2
      |> Entity.send_input("go east")
      # to east-corridor-3
      |> Entity.send_input("go east")
      # to ring-1
      |> Entity.send_input("go south")
      # to ring-2
      |> Entity.send_input("go southwest")
      # to ring-3
      |> Entity.send_input("go southwest")
      # to ring-4
      |> Entity.send_input("go southwest")
      # to south-corridor-3
      |> Entity.send_input("go west")

      assert Entity.location(entity) == {:thing, "scene:well:infrared:south-corridor-3", "floor"}

      entity
      # to ring-5
      |> Entity.send_input("go west")
      # to ring-6
      |> Entity.send_input("go northwest")
      # to ring-7
      |> Entity.send_input("go northwest")
      # to ring-8
      |> Entity.send_input("go northwest")
      # to west-corridor-3
      |> Entity.send_input("go north")

      assert Entity.location(entity) == {:thing, "scene:well:infrared:west-corridor-3", "floor"}

      entity
      # to ring-9
      |> Entity.send_input("go north")
      # to ring-10
      |> Entity.send_input("go northeast")
      # to ring-11
      |> Entity.send_input("go northeast")
      # to ring-12
      |> Entity.send_input("go northeast")
      # to north-corridor-3
      |> Entity.send_input("go east")

      assert Entity.location(entity) == {:thing, "scene:well:infrared:north-corridor-3", "floor"}

      entity
      # to ring-13
      |> Entity.send_input("go east")
      # to ring-14
      |> Entity.send_input("go southeast")
      # to ring-15
      |> Entity.send_input("go southeast")
      # to ring-16
      |> Entity.send_input("go southeast")
      # to east-corridor-3
      |> Entity.send_input("go south")

      assert Entity.location(entity) == {:thing, "scene:well:infrared:east-corridor-3", "floor"}
    end
  end
end
