defmodule Back.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:user_id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user" do
    field :username, :string
    field :email, :string
    field :phone, :string
    field :created_at, :string
    field :verified, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :phone, :created_at, :verified])
    |> validate_required([:username, :email, :phone, :created_at, :verified])
  end
end
