defmodule Back.Repo.Migrations.ChangeIdTypeFavorite do
  use Ecto.Migration

  def change do
    alter table(:favorite) do
      add :new_id, :binary_id
    end

    # execute "UPDATE favorite set new_id = id::bytea"

    create unique_index(:favorite, :new_id)

    alter table(:favorite) do
      remove :id
    end

    rename table(:favorite), :new_id, to: :id

    alter table(:favorite) do
      modify :id, :binary_id, primary_key: true
    end
  end
end
