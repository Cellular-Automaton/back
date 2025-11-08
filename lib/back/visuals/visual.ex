defmodule Back.Visuals.Visual do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "visuals" do
    field :name, :string
    field :description, :string
    field :assets_link, :string
    field :posted_by, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(visual, attrs) do
    visual
    |> cast(attrs, [:name, :description, :assets_link])
    |> validate_required([:name, :description, :assets_link])
  end
end
