defmodule Exinfiltr8.Master do
  use Militerm.Master, based_on: Militerm.Master.Default

  def character_start_data(attrs) do
    {nominative, objective, possessive} =
      case attrs["gender"] do
        "male" -> {"he", "him", "his"}
        "female" -> {"she", "her", "her"}
        "neuter" -> {"hi", "hir", "hir"}
        _ -> {"they", "them", "their"}
      end

    %{
      detail: %{
        "default" => %{
          "nouns" => [attrs["name"], "human"],
          "short" => attrs["cap_name"],
          "adjectives" => [attrs["gender"], "human"],
          "sight" => attrs["cap_name"] <> " is a run of the mill human."
        }
      },
      identity: %{
        "name" => attrs["cap_name"],
        "nominative" => nominative,
        "objective" => objective,
        "possessive" => possessive
      },
      location: %{
        "position" => "standing"
      }
    }
  end
end
