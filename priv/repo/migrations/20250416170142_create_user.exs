defmodule Back.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :user_id, :string
      add :username, :string
      add :email, :string
      add :phone, :string
      add :created_at, :string
      add :verified, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
