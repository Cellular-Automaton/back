defmodule Back.Repo.Migrations.ChangeIdTypeCommentBlocked do
  use Ecto.Migration

  def change do
    # comment table
    alter table(:comment) do
      add :new_comment_id, :binary
    end

    execute "UPDATE comment SET new_comment_id = comment_id::bytea"

    create unique_index(:comment, :new_comment_id)

    alter table(:comment) do
      remove :comment_id
    end

    rename table(:comment), :new_comment_id, to: :comment_id

    alter table(:comment) do
      modify :comment_id, :binary, primary_key: true
    end

    # blocked table
    alter table(:blocked) do
      add :new_blocked_id, :binary
    end

    execute "UPDATE blocked SET new_blocked_id = blocked_id::bytea"

    create unique_index(:blocked, :new_blocked_id)

    alter table(:blocked) do
      remove :blocked_id
    end

    rename table(:blocked), :new_blocked_id, to: :blocked_id

    alter table(:blocked) do
      modify :blocked_id, :binary, primary_key: true
    end
  end
end
