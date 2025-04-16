defmodule Back.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :post_id, :string
      add :edited, :boolean, default: false, null: false
      add :title, :string
      add :contents, :string
      add :posted_by, references(:user, on_delete: :nothing)
      add :viewed_by, references(:user, on_delete: :nothing)
      add :liked_by, references(:user, on_delete: :nothing)
      add :disliked_by, references(:user, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:post, [:posted_by])
    create index(:post, [:viewed_by])
    create index(:post, [:liked_by])
    create index(:post, [:disliked_by])
  end
end
