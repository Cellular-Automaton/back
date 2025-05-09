defmodule Back.Posts.PostActions do
  @moduledoc """
  The Posts.PostActions context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.Posts.PostActions.PostAction

  @doc """
  Returns the list of posts_actions.

  ## Examples

      iex> list_posts_actions()
      [%PostActions{}, ...]

  """
  def list_posts_actions() do
    Repo.all(PostAction)
  end

  @doc """
  Gets a single post_actions.

  Raises `Ecto.NoResultsError` if the Post actions does not exist.

  ## Examples

      iex> get_post_actions!(123)
      %PostActions{}

      iex> get_post_actions!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post_actions!(id), do: Repo.get!(PostAction, id)

  @doc """
  Creates a post_actions.

  ## Examples

      iex> create_post_actions(%{field: value})
      {:ok, %PostActions{}}

      iex> create_post_actions(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post_actions(attrs \\ %{}) do
    %PostAction{}
    |> PostAction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post_actions.

  ## Examples

      iex> update_post_actions(post_actions, %{field: new_value})
      {:ok, %PostActions{}}

      iex> update_post_actions(post_actions, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post_actions(%PostAction{} = post_actions, attrs) do
    post_actions
    |> PostAction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post_actions.

  ## Examples

      iex> delete_post_actions(post_actions)
      {:ok, %PostActions{}}

      iex> delete_post_actions(post_actions)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post_actions(%PostAction{} = post_actions) do
    Repo.delete(post_actions)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post_actions changes.

  ## Examples

      iex> change_post_actions(post_actions)
      %Ecto.Changeset{data: %PostActions{}}

  """
  def change_post_actions(%PostAction{} = post_actions, attrs \\ %{}) do
    PostAction.changeset(post_actions, attrs)
  end
end
