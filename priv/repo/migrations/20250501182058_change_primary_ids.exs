defmodule Back.Repo.Migrations.ChangePrimaryIds do
  use Ecto.Migration

  # update every id (that was auto-generated) to {table_name}_id except for table user
  def change do
    # create unique constraints to ids
    create unique_index(:automaton, :automaton_id)
    create unique_index(:blocked, :blocked_id)
    create unique_index(:comment, :comment_id)
    create unique_index(:post, :post_id)

    # drop foreign key constraints
    execute "ALTER TABLE comment DROP CONSTRAINT comment_post_id_fkey"
    execute "ALTER TABLE favorite DROP CONSTRAINT favorite_automaton_id_fkey"

    # update foreign keys in tables
    alter table(:comment) do
      modify :post_id, references(:post, type: :string, column: :post_id)
    end

    alter table(:favorite) do
      modify :automaton_id, references(:automaton, type: :string, column: :automaton_id)
    end

    # delete :id and change :{table}_id to primary key
    alter table(:automaton) do
      remove :id
      modify :automaton_id, :string, primary_key: true
    end

    alter table(:blocked) do
      remove :id
      modify :blocked_id, :string, primary_key: true
    end

    alter table(:comment) do
      remove :id
      modify :comment_id, :string, primary_key: true
    end

    alter table(:post) do
      remove :id
      modify :post_id, :string, primary_key: true
    end
  end
end
