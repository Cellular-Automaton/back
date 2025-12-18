defmodule BackWeb.PluginManagerController do
  use BackWeb, :controller

  alias Back.Plugins.Manager
  alias Back.Plugins.Manager.PluginManager

  action_fallback BackWeb.FallbackController

  # def index(conn, _params) do
  #   plugin_manager = Manager.list_plugin_manager()
  #   render(conn, :index, plugin_manager: plugin_manager)
  # end

  def create(conn, %{"plugin_manager" => plugin_manager_params}) do
    with {:ok, %PluginManager{} = plugin_manager} <-
           Manager.create_plugin_manager(plugin_manager_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/plugin_manager/#{plugin_manager}")
      |> render(:show, plugin_manager: plugin_manager)
    end
  end

  def update(conn, %{"id" => id, "plugin_manager" => plugin_manager_params}) do
    plugin_manager = Manager.get_plugin_manager!(id)

    with {:ok, %PluginManager{} = plugin_manager} <-
           Manager.update_plugin_manager(plugin_manager, plugin_manager_params) do
      render(conn, :show, plugin_manager: plugin_manager)
    end
  end

  def delete(conn, %{"id" => id}) do
    plugin_manager = Manager.get_plugin_manager!(id)

    with {:ok, %PluginManager{}} <- Manager.delete_plugin_manager(plugin_manager) do
      send_resp(conn, :no_content, "")
    end
  end

  @doc """
  Get a visual id and return all automaton associated with it + the user that created each automaton
  """
  def show_automatons(conn, %{"id" => id}) do
    data = Manager.get_automaton_by_visuals_id!(id)

    render(conn, :index_automaton, plugin_manager: data)
  end

  @doc """
  Get an automaton id and return all visuals associated with it + the user that created each visual
  """
  def show_visuals(conn, %{"id" => id}) do
    data = Manager.get_visuals_by_automaton_id!(id)

    render(conn, :index_visual, plugin_manager: data)
  end
end
