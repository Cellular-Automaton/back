defmodule Back.Repo.Migrations.FavoriteBinaryNotBinaryIdType do
  use Ecto.Migration

  def change do
    alter table(:favorite) do
      add :new_id, :binary
    end

    drop unique_index(:favorite, :new_id)

    # execute "UPDATE favorite set new_id = id"

    create unique_index(:favorite, :new_id)

    alter table(:favorite) do
      remove :id
    end

    rename table(:favorite), :new_id, to: :id

    alter table(:favorite) do
      modify :id, :binary, primary_key: true
    end
  end
end
