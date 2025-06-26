defmodule Back.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo
  alias Argon2

  alias Back.Users.User
  alias Back.Data.Image.Images

  @doc """
  Returns the list of user.

  ## Examples

      iex> list_user()
      [%User{}, ...]

  """
  def list_user do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(user_id), do: Repo.get!(User, user_id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    IO.inspect(attrs, label: "Creating user with attrs")

    # note: create user first, then add user_id to image

    {res, user} =
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()

    cond do
      res != :ok ->
        ""

      attrs["profile_pic"] != nil ->
        %Images{}
        |> Images.changeset(Map.put(attrs["profile_pic"], "user_id", user.user_id))
        |> Repo.insert()

      true ->
        ""
    end

    {res, user}
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    query = from i in Images, where: i.user_id == ^user.user_id
    image = Repo.one(query)

    cond do
      attrs["profile_pic"] != nil ->
        Back.Data.Image.change_images(image, attrs["profile_pic"])

      true ->
        ""
    end

    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  # NOTE: with pictures

  def list_user_with_pic() do
    Repo.all(User) |> Repo.preload([:profile_pic])
  end

  def get_user_pic!(user_id) do
    Repo.get!(User, user_id)
    |> Repo.preload([:profile_pic])
  end

  # NOTE: functions for auth
  def get_user_by_email_and_password(email, password) do
    query = from u in User, where: u.email == ^email, where: u.password == ^password

    case Repo.one(query) do
      nil -> {:error, :unauthorized}
      user -> {:ok, user}
    end
  end

  def authenticate_user(email, plain_text_password) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.verify_pass(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
