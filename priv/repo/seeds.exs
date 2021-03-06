# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Exinfiltr8.Repo.insert!(%Exinfiltr8.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
if !Militerm.Accounts.get_group_by_name("admin") do
  Exinfiltr8.Repo.insert!(%Militerm.Accounts.Group{
    name: "admin",
    description: "Administrators have all permissions."
  })
end

if !Militerm.Accounts.get_group_by_name("players") do
  Exinfiltr8.Repo.insert!(%Militerm.Accounts.Group{
    name: "players",
    description: "All players are always in this group."
  })
end
