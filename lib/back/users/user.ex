defmodule Back.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :username, :string
    field :user_id, :string
    field :email, :string
    field :phone, :string
    field :created_at, :string
    field :verified, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_id, :username, :email, :phone, :created_at, :verified])
    |> validate_required([:user_id, :username, :email, :phone, :created_at, :verified])
  end
end
