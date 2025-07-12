defmodule Back.Data.Files.File do
  use Ecto.Schema
  import Ecto.Changeset

  # @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:contents, :name]}
  schema "file" do
    field :name, :string
    field :contents, :binary

    belongs_to :automaton, Back.Automatons.Automaton,
      foreign_key: :automaton_id,
      type: :binary_id,
      references: :automaton_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(file, attrs) do
    file
    |> cast(attrs, [:contents, :name, :automaton_id])
    |> validate_required([:contents, :name])
  end
end
