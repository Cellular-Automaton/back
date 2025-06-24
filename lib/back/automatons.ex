defmodule Back.Automatons do
  @moduledoc """
  The Automatons context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.Automatons.Automaton
  alias Back.Data.Image.Images

  @doc """
  Returns the list of automaton.

  ## Examples

      iex> list_automaton()
      [%Automaton{}, ...]

  """
  def list_automaton do
    Repo.all(Automaton)
  end

  @doc """
  Gets a single automaton.

  Raises `Ecto.NoResultsError` if the Automaton does not exist.

  ## Examples

      iex> get_automaton!(123)
      %Automaton{}

      iex> get_automaton!(456)
      ** (Ecto.NoResultsError)

  """
  def get_automaton!(id), do: Repo.get!(Automaton, id)

  @doc """
  Creates a automaton.

  ## Examples

      iex> create_automaton(%{field: value})
      {:ok, %Automaton{}}

      iex> create_automaton(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_automaton(attrs \\ %{}) do
    # TODO: fetch user data & put it as posted_by
    auto =
      %Automaton{}
      |> Automaton.changeset(attrs)
      |> Repo.insert()

    cond do
      elem(auto, 0) != :ok ->
        ""

      attrs["image"] != nil ->
        content = elem(auto, 1)

        for automaton <- attrs["image"] do
          %Images{}
          |> Images.changeset(Map.put(automaton, "automaton_id", content.automaton_id))
          |> Repo.insert()
        end

      true ->
        ""
    end

    auto
  end

  @doc """
  Updates a automaton.

  ## Examples

      iex> update_automaton(automaton, %{field: new_value})
      {:ok, %Automaton{}}

      iex> update_automaton(automaton, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_automaton(%Automaton{} = automaton, attrs) do
    automaton
    |> Automaton.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a automaton.

  ## Examples

      iex> delete_automaton(automaton)
      {:ok, %Automaton{}}

      iex> delete_automaton(automaton)
      {:error, %Ecto.Changeset{}}

  """
  def delete_automaton(%Automaton{} = automaton) do
    Repo.delete(automaton)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking automaton changes.

  ## Examples

      iex> change_automaton(automaton)
      %Ecto.Changeset{data: %Automaton{}}

  """
  def change_automaton(%Automaton{} = automaton, attrs \\ %{}) do
    Automaton.changeset(automaton, attrs)
  end
end
