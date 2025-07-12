defmodule Back.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:comment_id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comment" do
    field :edited, :boolean, default: false
    field :contents, :string
    field :posted_by, :binary_id
    field :post_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:edited, :contents, :posted_by, :post_id])
    |> validate_required([:edited, :contents])
  end
end
