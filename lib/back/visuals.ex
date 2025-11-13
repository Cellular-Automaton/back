defmodule Back.Visuals do
  @moduledoc """
  The Visuals context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.Visuals.Visual

  @doc """
  Returns the list of visuals.

  ## Examples

      iex> list_visuals()
      [%Visual{}, ...]

  """
  def list_visuals do
    Repo.all(Visual)
  end

  @doc """
  Gets a single visual.

  Raises `Ecto.NoResultsError` if the Visual does not exist.

  ## Examples

      iex> get_visual!(123)
      %Visual{}

      iex> get_visual!(456)
      ** (Ecto.NoResultsError)

  """
  def get_visual!(id), do: Repo.get!(Visual, id)

  @doc """
  Creates a visual.

  ## Examples

      iex> create_visual(%{field: value})
      {:ok, %Visual{}}

      iex> create_visual(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_visual(attrs \\ %{}) do
    %Visual{}
    |> Visual.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a visual.

  ## Examples

      iex> update_visual(visual, %{field: new_value})
      {:ok, %Visual{}}

      iex> update_visual(visual, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_visual(%Visual{} = visual, attrs) do
    visual
    |> Visual.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a visual.

  ## Examples

      iex> delete_visual(visual)
      {:ok, %Visual{}}

      iex> delete_visual(visual)
      {:error, %Ecto.Changeset{}}

  """
  def delete_visual(%Visual{} = visual) do
    Repo.delete(visual)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking visual changes.

  ## Examples

      iex> change_visual(visual)
      %Ecto.Changeset{data: %Visual{}}

  """
  def change_visual(%Visual{} = visual, attrs \\ %{}) do
    Visual.changeset(visual, attrs)
  end
end
