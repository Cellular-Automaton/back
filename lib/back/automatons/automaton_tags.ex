defmodule Back.Automatons.AutomatonTags do
  @moduledoc """
  The Automatons.AutomatonTags context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.Automatons.AutomatonTags.AutomatonTag
  alias Back.Automatons.Tags.Tag

  @doc """
  Returns the list of automaton_tag.

  ## Examples

      iex> list_automaton_tag()
      [%AutomatonTag{}, ...]

  """
  def list_automaton_tag do
    Repo.all(AutomatonTag)
  end

  @doc """
  Gets a single automaton_tag.

  Raises `Ecto.NoResultsError` if the Automaton tag does not exist.

  ## Examples

      iex> get_automaton_tag!(123)
      %AutomatonTag{}

      iex> get_automaton_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_automaton_tag!(id), do: Repo.get!(AutomatonTag, id)

  @doc """
  Creates a automaton_tag.

  ## Examples

      iex> create_automaton_tag(%{field: value})
      {:ok, %AutomatonTag{}}

      iex> create_automaton_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_automaton_tag(attrs \\ %{}) do
    %AutomatonTag{}
    |> AutomatonTag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a automaton_tag.

  ## Examples

      iex> update_automaton_tag(automaton_tag, %{field: new_value})
      {:ok, %AutomatonTag{}}

      iex> update_automaton_tag(automaton_tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_automaton_tag(%AutomatonTag{} = automaton_tag, attrs) do
    automaton_tag
    |> AutomatonTag.changeset(attrs)
  end

  @doc """
  Deletes a automaton_tag.

  ## Examples

      iex> delete_automaton_tag(automaton_tag)
      {:ok, %AutomatonTag{}}

      iex> delete_automaton_tag(automaton_tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_automaton_tag(%AutomatonTag{} = automaton_tag) do
    Repo.delete(automaton_tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking automaton_tag changes.

  ## Examples

      iex> change_automaton_tag(automaton_tag)
      %Ecto.Changeset{data: %AutomatonTag{}}

  """
  def change_automaton_tag(%AutomatonTag{} = automaton_tag, attrs \\ %{}) do
    AutomatonTag.changeset(automaton_tag, attrs)
  end

  def get_tags_by_automaton_id!(id) do
    query =
      from at1 in AutomatonTag,
        join: t in Tag,
        on: t.id == at1.tag_id,
        where: at1.automaton_id == ^id,
        select: %{
          automaton: at1.automaton_id,
          tag_id: t.id,
          tag_name: t.name,
          tag_description: t.description
        }

    Repo.all(query)
  end
end
