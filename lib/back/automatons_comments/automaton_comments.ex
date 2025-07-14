defmodule Back.AutomatonsComments.AutomatonComments do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "automaton_comment" do
    field :edited, :boolean, default: false
    field :contents, :string
    field :posted_by, :binary_id
    field :automaton_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(automaton_comments, attrs) do
    automaton_comments
    |> cast(attrs, [:edited, :contents, :posted_by, :automaton_id])
    |> validate_required([:edited, :contents])
  end
end
