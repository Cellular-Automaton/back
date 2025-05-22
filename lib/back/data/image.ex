defmodule Back.Data.Image do
  @moduledoc """
  The Data.Image context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.Data.Image.Images

  @doc """
  Returns the list of image.

  ## Examples

      iex> list_image()
      [%Images{}, ...]

  """
  def list_image do
    Repo.all(Images)
  end

  @doc """
  Gets a single images.

  Raises `Ecto.NoResultsError` if the Images does not exist.

  ## Examples

      iex> get_images!(123)
      %Images{}

      iex> get_images!(456)
      ** (Ecto.NoResultsError)

  """
  def get_images!(id), do: Repo.get!(Images, id)

  @doc """
  Creates a images.

  ## Examples

      iex> create_images(%{field: value})
      {:ok, %Images{}}

      iex> create_images(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_images(attrs \\ %{}) do
    %Images{}
    |> Images.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a images.

  ## Examples

      iex> update_images(images, %{field: new_value})
      {:ok, %Images{}}

      iex> update_images(images, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_images(%Images{} = images, attrs) do
    images
    |> Images.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a images.

  ## Examples

      iex> delete_images(images)
      {:ok, %Images{}}

      iex> delete_images(images)
      {:error, %Ecto.Changeset{}}

  """
  def delete_images(%Images{} = images) do
    Repo.delete(images)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking images changes.

  ## Examples

      iex> change_images(images)
      %Ecto.Changeset{data: %Images{}}

  """
  def change_images(%Images{} = images, attrs \\ %{}) do
    Images.changeset(images, attrs)
  end
end
