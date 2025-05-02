defmodule Back.Repo.Migrations.ChangeUserTable do
  use Ecto.Migration

  @type_name :user_role

  def change do
    execute(
      """
      CREATE TYPE #{@type_name} AS ENUM (
      'admin',
      'developer',
      'user'
      )
      """,
      "DROP TYPE IF EXISTS #{@type_name}"
    )

    alter table(:user) do
      add :password, :string
      add :user_role, @type_name
      remove :user_id

      add :user_id, :string
    end

    execute "UPDATE \"user\" SET user_id = id::text"

    # add unique constraint to user_id col
    create unique_index(:user, :user_id)

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
      modify :liked_by, references(:user, type: :string, column: :user_id)
      modify :viewed_by, references(:user, type: :string, column: :user_id)
      modify :posted_by, references(:user, type: :string, column: :user_id)
      modify :disliked_by, references(:user, type: :string, column: :user_id)
    end

    alter table(:automaton) do
      modify :posted_by, references(:user, type: :string, column: :user_id)
      modify :viewed_by, references(:user, type: :string, column: :user_id)
    end

    alter table(:comment) do
      modify :posted_by, references(:user, type: :string, column: :user_id)
    end

    alter table(:blocked) do
      modify :user_id, references(:user, type: :string, column: :user_id)
    end

    alter table(:favorite) do
      modify :user_id, references(:user, type: :string, column: :user_id)
    end

    alter table(:user) do
      remove :id
      modify :user_id, :string, primary_key: true
    end
  end
end
