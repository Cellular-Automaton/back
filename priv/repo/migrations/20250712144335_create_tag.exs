defmodule Back.Repo.Migrations.CreateTag do
  use Ecto.Migration

  def change do
    create table(:tag, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:tag, [:name])
  end
end
