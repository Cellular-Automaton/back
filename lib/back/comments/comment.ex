defmodule Back.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:comment_id, :binary_id, autogenerate: true}
  schema "comment" do
    field :edited, :boolean, default: false
    field :contents, :string
    field :posted_by, :id
    field :post_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:edited, :contents])
    |> validate_required([:edited, :contents])
  end
end
