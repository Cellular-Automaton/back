defmodule Back.Repo.Migrations.CreateFile do
  use Ecto.Migration

  def change do
    create table(:file) do
      add :contents, :binary
      add :name, :string

      add :automaton_id,
          references(:automaton, on_delete: :nothing, column: :automaton_id, type: :binary)

      timestamps(type: :utc_datetime)
    end

    create index(:file, [:automaton_id])
  end
end
