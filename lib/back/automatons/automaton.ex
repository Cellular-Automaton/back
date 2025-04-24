defmodule Back.Automatons.Automaton do
  use Ecto.Schema
  import Ecto.Changeset

  schema "automaton" do
    field :name, :string
    field :description, :string
    field :automaton_id, :string
    field :contents, :string
    field :posted_by, :id
    field :viewed_by, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(automaton, attrs) do
    automaton
    |> cast(attrs, [:automaton_id, :contents, :name, :description])
    |> validate_required([:automaton_id, :contents, :name, :description])
  end
end
