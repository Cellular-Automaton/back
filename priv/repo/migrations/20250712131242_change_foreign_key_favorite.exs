defmodule Back.Repo.Migrations.ChangeForeignKeyFavorite do
  use Ecto.Migration

  def change do
    alter table(:favorite) do
      add :new_user_id, references(:user, on_delete: :nothing, type: :binary, column: :user_id)

      add :new_automaton_id,
          references(:automaton, on_delete: :nothing, type: :binary, column: :automaton_id)
    end

    create index(:favorite, [:new_user_id])
    create index(:favorite, [:new_automaton_id])

    alter table(:favorite) do
      remove :user_id
      remove :automaton_id
    end

    rename table(:favorite), :new_user_id, to: :user_id
    rename table(:favorite), :new_automaton_id, to: :automaton_id
  end
end
