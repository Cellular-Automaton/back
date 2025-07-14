defmodule Back.Repo.Migrations.FavoriteUniqueConstraint do
  use Ecto.Migration

  def change do
    create unique_index(:favorite, [:user_id, :automaton_id], name: :favorite_unique_index)
  end
end
