defmodule Back.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post" do
    field :title, :string
    field :post_id, :string
    field :edited, :boolean, default: false
    field :contents, :string
    field :posted_by, :id
    field :viewed_by, :id
    field :liked_by, :id
    field :disliked_by, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:post_id, :edited, :title, :contents])
    |> validate_required([:post_id, :edited, :title, :contents])
  end
end
