defmodule Back.Favorites.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "favorite" do

    field :user_id, :id
    field :automaton_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [])
    |> validate_required([])
  end
end
