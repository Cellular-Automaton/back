defmodule Back.AutomatonsComments do
  @moduledoc """
  The AutomatonsComments context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.AutomatonsComments.AutomatonComments
  alias Back.Users.User

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

  def get_by_automaton_id!(id) do
    query =
      from ac in AutomatonComments,
        join: u in User,
        on: u.user_id == ac.posted_by,
        where: ac.automaton_id == ^id,
        select: %{
          id: ac.id,
          edited: ac.edited,
          contents: ac.contents,
          automaton_id: ac.automaton_id,
          inserted_at: ac.inserted_at,
          updated_at: ac.updated_at,
          posted_by: %{
            user_id: u.user_id,
            username: u.username,
            email: u.email,
            phone: u.phone,
            created_at: u.created_at,
            user_role: u.user_role
          }
        }

    Repo.all(query)
  end

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
