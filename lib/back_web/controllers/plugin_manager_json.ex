defmodule BackWeb.PluginManagerJSON do
  alias Back.Plugins.Manager.PluginManager

  @doc """
  Renders a list of plugin_manager.
  """
  def index(%{plugin_manager: plugin_manager}) do
    %{data: for(plugin_manager <- plugin_manager, do: data(plugin_manager))}
  end

  @doc """
  Renders a single plugin_manager.
  """
  def show(%{plugin_manager: plugin_manager}) do
    %{data: data(plugin_manager)}
  end

  defp data(%PluginManager{} = plugin_manager) do
    %{
      id: plugin_manager.id
    }
  end
end
