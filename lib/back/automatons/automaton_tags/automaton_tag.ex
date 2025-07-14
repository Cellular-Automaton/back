defmodule Back.Automatons.AutomatonTags.AutomatonTag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "automaton_tag" do
    field :tag_id, :binary_id
    field :automaton_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(automaton_tag, attrs) do
    automaton_tag
    |> cast(attrs, [:tag_id, :automaton_id])
    |> unique_constraint(:tag_automaton_unique_constraint, name: :automaton_tag_unique_index)
    |> validate_required([])
  end
end
