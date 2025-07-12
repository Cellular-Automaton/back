defmodule Back.Favorites.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "favorite" do
    field :user_id, :binary_id
    field :automaton_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [:user_id, :automaton_id])
    |> unique_constraint(:user_automaton_unique_constraint, name: :favorite_unique_index)
    |> validate_required([])
  end
end
