defmodule Back.Repo.Migrations.CreateFavorite do
  use Ecto.Migration

  def change do
    create table(:favorite) do
      add :user_id, references(:user, on_delete: :nothing)
      add :automaton_id, references(:automaton, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:favorite, [:user_id])
    create index(:favorite, [:automaton_id])
  end
end
