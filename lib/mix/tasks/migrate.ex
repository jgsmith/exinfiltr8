defmodule Mix.Tasks.Migrate do
  use Mix.Task

  @shortdoc "Run migrations for this project and dependencies"
  def run(_) do
    migrate_child_app()
    Mix.Task.run("ecto.migrate")
  end

  def migrate_child_app do
    {:ok, _} = Application.ensure_all_started(:exinfiltr8)

    path = Application.app_dir(:militerm, "priv/repo/migrations")
    Ecto.Migrator.run(Exinfiltr8.Repo, path, :up, all: true)
  end
end
