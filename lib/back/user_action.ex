defmodule Back.UserAction do
  @moduledoc """
  The UserAction context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.UserAction.Blocked

  @doc """
  Returns the list of blocked.

  ## Examples

      iex> list_blocked()
      [%Blocked{}, ...]

  """
  def list_blocked do
    Repo.all(Blocked)
  end

  @doc """
  Gets a single blocked.

  Raises `Ecto.NoResultsError` if the Blocked does not exist.

  ## Examples

      iex> get_blocked!(123)
      %Blocked{}

      iex> get_blocked!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blocked!(id), do: Repo.get!(Blocked, id)

  @doc """
  Creates a blocked.

  ## Examples

      iex> create_blocked(%{field: value})
      {:ok, %Blocked{}}

      iex> create_blocked(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blocked(attrs \\ %{}) do
    %Blocked{}
    |> Blocked.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blocked.

  ## Examples

      iex> update_blocked(blocked, %{field: new_value})
      {:ok, %Blocked{}}

      iex> update_blocked(blocked, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blocked(%Blocked{} = blocked, attrs) do
    blocked
    |> Blocked.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a blocked.

  ## Examples

      iex> delete_blocked(blocked)
      {:ok, %Blocked{}}

      iex> delete_blocked(blocked)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blocked(%Blocked{} = blocked) do
    Repo.delete(blocked)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blocked changes.

  ## Examples

      iex> change_blocked(blocked)
      %Ecto.Changeset{data: %Blocked{}}

  """
  def change_blocked(%Blocked{} = blocked, attrs \\ %{}) do
    Blocked.changeset(blocked, attrs)
  end
end
