defmodule Back.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:post_id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "post" do
    field :title, :string
    field :edited, :boolean, default: false
    field :contents, :string
    field :posted_by, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:edited, :title, :contents])
    |> validate_required([:edited, :title, :contents])
  end
end
