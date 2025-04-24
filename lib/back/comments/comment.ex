defmodule Back.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comment" do
    field :comment_id, :string
    field :edited, :boolean, default: false
    field :contents, :string
    field :posted_by, :id
    field :post_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:comment_id, :edited, :contents])
    |> validate_required([:comment_id, :edited, :contents])
  end
end
