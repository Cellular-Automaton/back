defmodule Back.Posts.PostActions.PostAction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts_actions" do
    field :action, :string
    many_to_many :user_id, Back.Users.User, join_through: "user_id"
    many_to_many :post_id, Back.Posts.Post, join_through: "post_id"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post_actions, attrs) do
    post_actions
    |> cast(attrs, [:action])
    |> validate_required([:action])
    |> validate_inclusion(:action, ~w(liked disliked viewed))
  end
end
