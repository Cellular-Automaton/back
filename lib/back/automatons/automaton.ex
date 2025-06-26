defmodule Back.Automatons.Automaton do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:automaton_id, :binary_id, autogenerate: true}
  schema "automaton" do
    field :name, :string
    field :description, :string
    field :contents, :string
    field :posted_by, :id
    field :viewed_by, :id

    has_many :image, Back.Data.Image.Images, foreign_key: :automaton_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(automaton, attrs) do
    automaton
    |> cast(attrs, [:contents, :name, :description])
    |> validate_required([:contents, :name, :description])
  end
end
