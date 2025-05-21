defmodule Back.AutomatonsComments do
  @moduledoc """
  The AutomatonsComments context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.AutomatonsComments.AutomatonComments

  @doc """
  Returns the list of automaton_comment.

  ## Examples

      iex> list_automaton_comment()
      [%AutomatonComments{}, ...]

  """
  def list_automaton_comment do
    Repo.all(AutomatonComments)
  end

  @doc """
  Gets a single automaton_comments.

  Raises `Ecto.NoResultsError` if the Automaton comments does not exist.

  ## Examples

      iex> get_automaton_comments!(123)
      %AutomatonComments{}

      iex> get_automaton_comments!(456)
      ** (Ecto.NoResultsError)

  """
  def get_automaton_comments!(id), do: Repo.get!(AutomatonComments, id)

  @doc """
  Creates a automaton_comments.

  ## Examples

      iex> create_automaton_comments(%{field: value})
      {:ok, %AutomatonComments{}}

      iex> create_automaton_comments(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_automaton_comments(attrs \\ %{}) do
    %AutomatonComments{}
    |> AutomatonComments.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a automaton_comments.

  ## Examples

      iex> update_automaton_comments(automaton_comments, %{field: new_value})
      {:ok, %AutomatonComments{}}

      iex> update_automaton_comments(automaton_comments, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_automaton_comments(%AutomatonComments{} = automaton_comments, attrs) do
    automaton_comments
    |> AutomatonComments.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a automaton_comments.

  ## Examples

      iex> delete_automaton_comments(automaton_comments)
      {:ok, %AutomatonComments{}}

      iex> delete_automaton_comments(automaton_comments)
      {:error, %Ecto.Changeset{}}

  """
  def delete_automaton_comments(%AutomatonComments{} = automaton_comments) do
    Repo.delete(automaton_comments)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking automaton_comments changes.

  ## Examples

      iex> change_automaton_comments(automaton_comments)
      %Ecto.Changeset{data: %AutomatonComments{}}

  """
  def change_automaton_comments(%AutomatonComments{} = automaton_comments, attrs \\ %{}) do
    AutomatonComments.changeset(automaton_comments, attrs)
  end
end
