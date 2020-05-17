defmodule Verbs.TellTest do
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

  describe "tell someone something" do
    @tag diegetic: true
    test "runs", %{entity: entity} do
      entity
      |> Entity.send_input("tell someone something")
    end
  end
end
