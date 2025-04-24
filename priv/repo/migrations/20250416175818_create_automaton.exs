defmodule Back.Repo.Migrations.CreateAutomaton do
  use Ecto.Migration

  def change do
    create table(:automaton) do
      add :automaton_id, :string
      add :contents, :string
      add :name, :string
      add :description, :string
      add :posted_by, references(:user, on_delete: :nothing)
      add :viewed_by, references(:user, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:automaton, [:posted_by])
    create index(:automaton, [:viewed_by])
  end
end
