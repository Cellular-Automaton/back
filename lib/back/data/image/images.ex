defmodule Back.Data.Image.Images do
  use Ecto.Schema
  import Ecto.Changeset

  schema "image" do
    field :contents_binary, :binary
    field :contents_type, :string

    belongs_to :user, Back.Users.User,
      foreign_key: :user_id,
      type: :binary_id,
      references: :user_id

    belongs_to :automaton, Back.Automatons.Automaton,
      foreign_key: :automaton_id,
      type: :binary_id,
      references: :automaton_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(images, attrs) do
    images
    |> cast(attrs, [:contents_binary, :contents_type, :user_id, :automaton_id])
    |> validate_required([:contents_binary, :contents_type])
  end
end
