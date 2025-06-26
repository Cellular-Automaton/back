defmodule Back.Users.User do
  use Ecto.Schema
  alias Argon2
  import Ecto.Changeset

  @primary_key {:user_id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user" do
    field :username, :string
    field :email, :string
    field :password, :string
    field :phone, :string
    field :created_at, :utc_datetime
    field :verified, :boolean, default: false
    field :user_role, :string

    has_one :profile_pic, Back.Data.Image.Images, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_id, :username, :email, :phone, :verified, :user_role, :password])
    |> validate_required([:username, :email, :user_role, :password])
    |> validate_inclusion(:user_role, ~w(admin developer user))
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
