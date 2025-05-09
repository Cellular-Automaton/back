defmodule Back.Repo.Migrations.CreatePostsActions do
  use Ecto.Migration

  @enum_name :post_action_name

  def up do
    # NOTE: need to change id type of post table first
    ##

    execute "ALTER TABLE post DROP CONSTRAINT post_liked_by_fkey"
    execute "ALTER TABLE post DROP CONSTRAINT post_viewed_by_fkey"
    execute "ALTER TABLE post DROP CONSTRAINT post_disliked_by_fkey"

    alter table(:post) do
      add :new_post_id, :binary

      # deleting now useless rows (using them in posts_actions table)
      remove :liked_by
      remove :disliked_by
      remove :viewed_by
      remove :posted_by

      add :posted_by, references(:user, type: :binary, column: :user_id)
    end

    execute "UPDATE post SET new_post_id = post_id::bytea"

    create unique_index(:post, :new_post_id)

    # delete foreign key constraints
    alter table(:comment) do
      remove :post_id

      add :post_id, references(:post, type: :binary, column: :new_post_id)
    end

    alter table(:post) do
      remove :post_id
    end

    rename table("post"), :new_post_id, to: :post_id

    alter table(:post) do
      modify :post_id, :binary, primary_key: true
    end

    ##

    # NOTE: create new table
    create table(:posts_actions) do
      add :action, @enum_name
      add :user_id, references(:user, on_delete: :nothing, column: :user_id, type: :binary)
      add :post_id, references(:post, on_delete: :nothing, column: :post_id, type: :binary)

      timestamps(type: :utc_datetime)
    end

    create index(:posts_actions, [:user_id])
    create index(:posts_actions, [:post_id])
  end

  def down do
    # Reverse the creation of the posts_actions table
    drop table(:posts_actions)

    alter table(:post) do
      add :new_posts_id, :string

      # deleting now useless rows (using them in posts_actions table)
      add :liked_by, :binary
      add :disliked_by, :binary
      add :viewed_by, :binary
    end

    execute "UPDATE post SET new_posts_id = post_id::text"
    create unique_index(:post, :new_posts_id)

    # delete foreign key constraints
    alter table(:comment) do
      remove :post_id

      add :post_id, references(:post, type: :string, column: :new_posts_id)
    end

    alter table(:post) do
      remove :post_id
    end

    rename table("post"), :new_posts_id, to: :post_id

    alter table(:post) do
      modify :post_id, :string, primary_key: true
    end

    execute "ALTER TABLE post ADD CONSTRAINT post_liked_by_fkey FOREIGN KEY (liked_by) REFERENCES \"user\"(user_id)"

    execute "ALTER TABLE post ADD CONSTRAINT post_viewed_by_fkey FOREIGN KEY (viewed_by) REFERENCES \"user\"(user_id)"

    execute "ALTER TABLE post ADD CONSTRAINT post_disliked_by_fkey FOREIGN KEY (disliked_by) REFERENCES \"user\"(user_id)"

    execute "ALTER TABLE post ADD CONSTRAINT post_posted_by_fkey FOREIGN KEY (disliked_by) REFERENCES \"user\"(user_id)"
  end
end
