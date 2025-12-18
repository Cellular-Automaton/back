defmodule Back.Plugins.Manager do
  @moduledoc """
  The Plugins.Manager context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.Automatons.Automaton
  alias Back.Plugins.Manager.PluginManager
  alias Back.Visuals.Visual
  alias Back.Users.User

  @doc """
  Returns the list of plugin_manager.

  ## Examples

      iex> list_plugin_manager()
      [%PluginManager{}, ...]

  """
  def list_plugin_manager do
    Repo.all(PluginManager)
  end

  @doc """
  Gets a single plugin_manager.

  Raises `Ecto.NoResultsError` if the Plugin manager does not exist.

  ## Examples

      iex> get_plugin_manager!(123)
      %PluginManager{}

      iex> get_plugin_manager!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plugin_manager!(id), do: Repo.get!(PluginManager, id)

  @doc """
  Creates a plugin_manager.

  ## Examples

      iex> create_plugin_manager(%{field: value})
      {:ok, %PluginManager{}}

      iex> create_plugin_manager(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plugin_manager(attrs \\ %{}) do
    %PluginManager{}
    |> PluginManager.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plugin_manager.

  ## Examples

      iex> update_plugin_manager(plugin_manager, %{field: new_value})
      {:ok, %PluginManager{}}

      iex> update_plugin_manager(plugin_manager, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plugin_manager(%PluginManager{} = plugin_manager, attrs) do
    plugin_manager
    |> PluginManager.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plugin_manager.

  ## Examples

      iex> delete_plugin_manager(plugin_manager)
      {:ok, %PluginManager{}}

      iex> delete_plugin_manager(plugin_manager)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plugin_manager(%PluginManager{} = plugin_manager) do
    Repo.delete(plugin_manager)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plugin_manager changes.

  ## Examples

      iex> change_plugin_manager(plugin_manager)
      %Ecto.Changeset{data: %PluginManager{}}

  """
  def change_plugin_manager(%PluginManager{} = plugin_manager, attrs \\ %{}) do
    PluginManager.changeset(plugin_manager, attrs)
  end

  def get_visuals_by_automaton_id!(id) do
    query =
      from pm in PluginManager,
        join: v in Visual,
        on: v.id == pm.visual,
        left_join: u in User,
        on: v.posted_by == u.user_id,
        where: pm.automaton == ^id,
        select: %{
          id: v.id,
          name: v.name,
          description: v.description,
          assets_link: v.assets_link,
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

  def get_automaton_by_visuals_id!(id) do
    query =
      from pm in PluginManager,
        join: a in Automaton,
        on: a.automaton_id == pm.automaton,
        left_join: u in User,
        on: a.posted_by == u.user_id,
        where: pm.visual == ^id,
        select: %{
          id: a.automaton_id,
          name: a.name,
          description: a.description,
          contents: a.contents,
          assets_link: a.assets_link,
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
end
