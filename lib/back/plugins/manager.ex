defmodule Back.Plugins.Manager do
  @moduledoc """
  The Plugins.Manager context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.Plugins.Manager.PluginManager

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
end
