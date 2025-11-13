defmodule Back.Repo.Migrations.CreatePluginManager do
  use Ecto.Migration

  def change do
    create table(:plugin_manager, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :automaton,
          references(:automaton, column: :automaton_id, on_delete: :nothing, type: :binary)

      add :visual, references(:visuals, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:plugin_manager, [:automaton])
    create index(:plugin_manager, [:visual])
  end
end
