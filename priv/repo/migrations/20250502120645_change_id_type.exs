defmodule Back.Repo.Migrations.ChangeIdType do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :new_user_id, :binary
    end

    execute "UPDATE \"user\" SET new_user_id = user_id::bytea"

    # add unique constraint to user_id col
    create unique_index(:user, :new_user_id)

    # delete foreign key constraints
    execute "ALTER TABLE post DROP CONSTRAINT post_liked_by_fkey"
    execute "ALTER TABLE post DROP CONSTRAINT post_viewed_by_fkey"
    execute "ALTER TABLE post DROP CONSTRAINT post_posted_by_fkey"
    execute "ALTER TABLE post DROP CONSTRAINT post_disliked_by_fkey"
    execute "ALTER TABLE automaton DROP CONSTRAINT automaton_posted_by_fkey"
    execute "ALTER TABLE automaton DROP CONSTRAINT automaton_viewed_by_fkey"
    execute "ALTER TABLE comment DROP CONSTRAINT comment_posted_by_fkey"
    execute "ALTER TABLE blocked DROP CONSTRAINT blocked_user_id_fkey"
    execute "ALTER TABLE favorite DROP CONSTRAINT favorite_user_id_fkey"

    # update foreign keys in all tables

    alter table(:post) do
      remove :liked_by
      remove :viewed_by
      remove :posted_by
      remove :disliked_by

      add :liked_by, references(:user, type: :binary, column: :new_user_id)
      add :viewed_by, references(:user, type: :binary, column: :new_user_id)
      add :posted_by, references(:user, type: :binary, column: :new_user_id)
      add :disliked_by, references(:user, type: :binary, column: :new_user_id)
    end

    alter table(:automaton) do
      remove :posted_by
      remove :viewed_by

      add :posted_by, references(:user, type: :binary, column: :new_user_id)
      add :viewed_by, references(:user, type: :binary, column: :new_user_id)
    end

    alter table(:comment) do
      remove :posted_by

      add :posted_by, references(:user, type: :binary, column: :new_user_id)
    end

    alter table(:blocked) do
      remove :user_id

      add :user_id, references(:user, type: :binary, column: :new_user_id)
    end

    alter table(:favorite) do
      remove :user_id

      add :user_id, references(:user, type: :binary, column: :new_user_id)
    end

    alter table(:user) do
      remove :user_id
    end

    rename table("user"), :new_user_id, to: :user_id

    alter table(:user) do
      modify :user_id, :binary, primary_key: true
    end
  end
end
