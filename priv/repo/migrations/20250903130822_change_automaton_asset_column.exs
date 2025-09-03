defmodule Back.Repo.Migrations.ChangeAutomatonAssetColumn do
  use Ecto.Migration

  def up do
    alter table(:automaton) do
      add_if_not_exists :assets_link, :string
    end
  end

  def down do
    alter table(:automaton) do
      remove_if_exists :assets_link, default: ""
    end
  end
end
