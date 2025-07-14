defmodule Back.Repo.Migrations.CreateAutomatonTag do
  use Ecto.Migration

  def change do
    create table(:automaton_tag, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :tag_id, references(:tag, on_delete: :nothing, type: :binary_id)

      add :automaton_id,
          references(:automaton, on_delete: :nothing, type: :binary, column: :automaton_id)

      timestamps(type: :utc_datetime)
    end

    create index(:automaton_tag, [:tag_id])
    create index(:automaton_tag, [:automaton_id])
  end
end
