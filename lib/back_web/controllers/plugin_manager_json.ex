defmodule BackWeb.PluginManagerJSON do
  alias Back.Plugins.Manager.PluginManager

  # misc
  def show(%{plugin_manager: plugin_manager}) do
    %{data: data(plugin_manager)}
  end

  defp data(%PluginManager{} = data) do
    %{
      id: data.id,
      automaton: data.automaton,
      visual: data.visual
    }
  end

  @doc """
  Renders a list of plugin_manager.
  """
  def index_visual(%{plugin_manager: plugin_manager}) do
    %{data: for(plugin_manager <- plugin_manager, do: data_visual(plugin_manager))}
  end

  @doc """
  Renders a single plugin_manager.
  """
  def show_visual(%{plugin_manager: plugin_manager}) do
    %{data: data_visual(plugin_manager)}
  end

  defp data_visual(%{} = data) do
    %{
      id: data.id,
      name: data.name,
      description: data.description,
      assets_link: data.assets_link,
      posted_by: data.posted_by
    }
  end

  @doc """
  Renders a list of plugin_manager.
  """
  def index_automaton(%{plugin_manager: plugin_manager}) do
    %{data: for(plugin_manager <- plugin_manager, do: data_automaton(plugin_manager))}
  end

  @doc """
  Renders a single plugin_manager.
  """
  def show_automaton(%{plugin_manager: plugin_manager}) do
    %{data: data_automaton(plugin_manager)}
  end

  defp data_automaton(%{} = data) do
    %{
      id: data.id,
      name: data.name,
      description: data.description,
      contents: data.contents,
      assets_link: data.assets_link,
      posted_by: data.posted_by
    }
  end
end
