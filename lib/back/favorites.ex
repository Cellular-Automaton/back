defmodule Back.Favorites do
  @moduledoc """
  The Favorites context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.Favorites.Favorite

  @doc """
  Returns the list of favorite.

  ## Examples

      iex> list_favorite()
      [%Favorite{}, ...]

  """
  def list_favorite do
    Repo.all(Favorite)
  end

  @doc """
  Gets a single favorite.

  Raises `Ecto.NoResultsError` if the Favorite does not exist.

  ## Examples

      iex> get_favorite!(123)
      %Favorite{}

      iex> get_favorite!(456)
      ** (Ecto.NoResultsError)

  """
  def get_favorite!(id), do: Repo.get!(Favorite, id)

  @doc """
  Creates a favorite.

  ## Examples

      iex> create_favorite(%{field: value})
      {:ok, %Favorite{}}

      iex> create_favorite(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_favorite(attrs \\ %{}) do
    %Favorite{}
    |> Favorite.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a favorite.

  ## Examples

      iex> update_favorite(favorite, %{field: new_value})
      {:ok, %Favorite{}}

      iex> update_favorite(favorite, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_favorite(%Favorite{} = favorite, attrs) do
    favorite
    |> Favorite.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a favorite.

  ## Examples

      iex> delete_favorite(favorite)
      {:ok, %Favorite{}}

      iex> delete_favorite(favorite)
      {:error, %Ecto.Changeset{}}

  """
  def delete_favorite(%Favorite{} = favorite) do
    Repo.delete(favorite)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking favorite changes.

  ## Examples

      iex> change_favorite(favorite)
      %Ecto.Changeset{data: %Favorite{}}

  """
  def change_favorite(%Favorite{} = favorite, attrs \\ %{}) do
    Favorite.changeset(favorite, attrs)
  end

  def get_by_user!(user_id) do
    query = from f in Favorite, where: f.user_id == ^user_id

    Repo.all(query)
  end
end
