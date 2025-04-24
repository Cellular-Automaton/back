defmodule Back.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comment) do
      add :comment_id, :string
      add :edited, :boolean, default: false, null: false
      add :contents, :string
      add :posted_by, references(:user, on_delete: :nothing)
      add :post_id, references(:post, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:comment, [:posted_by])
    create index(:comment, [:post_id])
  end
end
