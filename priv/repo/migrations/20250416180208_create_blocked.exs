defmodule Back.Repo.Migrations.CreateBlocked do
  use Ecto.Migration

  def change do
    create table(:blocked) do
      add :blocked_id, :string
      add :time_unblock, :naive_datetime
      add :blocked_at, :naive_datetime
      add :user_id, references(:user, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:blocked, [:user_id])
  end
end
