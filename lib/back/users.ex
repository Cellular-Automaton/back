defmodule Back.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

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

    user =
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()

    cond do
      elem(user, 0) != :ok ->
        ""

      attrs["profile_pic"] != nil ->
        content = elem(user, 1)

        %Images{}
        |> Images.changeset(Map.put(attrs["profile_pic"], "user_id", content.user_id))
        |> Repo.insert()

      true ->
        ""
    end

    user
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

  # TODO: before merge, need to do create and update function with pictures
end
