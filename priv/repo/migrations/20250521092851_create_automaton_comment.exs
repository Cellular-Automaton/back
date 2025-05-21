defmodule Back.Repo.Migrations.CreateAutomatonComment do
  use Ecto.Migration

  def change do
    # NOTE: need to change id type of automaton table before
    alter table(:automaton) do
      add :new_automaton_id, :binary
    end

    execute "UPDATE automaton SET new_automaton_id = automaton_id::bytea"

    create unique_index(:automaton, :new_automaton_id)

    alter table(:favorite) do
      remove :automaton_id
      add :automaton_id, references(:automaton, type: :binary, column: :new_automaton_id)
    end

    alter table(:automaton) do
      remove :automaton_id
    end

    rename table("automaton"), :new_automaton_id, to: :automaton_id

    alter table(:automaton) do
      modify :automaton_id, :binary, primary_key: true
    end

    # NOTE: create new table automaton_comment
    create table(:automaton_comment, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :edited, :boolean, default: false, null: false
      add :contents, :string
      add :posted_by, references(:user, on_delete: :nothing, type: :binary, column: :user_id)

      add :automaton_id,
          references(:automaton, on_delete: :nothing, type: :binary, column: :automaton_id)

      timestamps(type: :utc_datetime)
    end

    create index(:automaton_comment, [:posted_by])
    create index(:automaton_comment, [:automaton_id])
  end
end
