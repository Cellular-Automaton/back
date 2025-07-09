defmodule BackWeb.AutomatonController do
  use BackWeb, :controller

  alias Back.Automatons
  alias Back.Automatons.Automaton
  alias Back.Data.Image

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    automaton = Automatons.list_automaton()
    render(conn, :index, automaton: automaton)
  end

  def index_img(conn, _params) do
    automaton = Automatons.list_automaton_with_img()
    render(conn, :index_image, automaton: automaton)
  end

  def create(conn, %{"automaton" => automaton_params}) do
    with {:ok, %Automaton{} = automaton} <- Automatons.create_automaton(automaton_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/automaton/#{automaton.automaton_id}")
      |> render(:show, automaton: automaton)
    end
  end

  def create_image(conn, %{"automaton" => automaton_params}) do
    with {:ok, %Automaton{} = automaton} <- Automatons.create_automaton(automaton_params) do
      {res, img} = Image.get_image_automaton_id(automaton.automaton_id)

      automaton =
        if res == :ok do
          Map.put(automaton, :image, img)
        end

      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/automaton/#{automaton.automaton_id}")
      |> render(:show_images, automaton: automaton)
    end
  end

  def show(conn, %{"id" => id}) do
    automaton = Automatons.get_automaton!(id)
    render(conn, :show, automaton: automaton)
  end

  def show_img(conn, %{"id" => id}) do
    automaton = Automatons.get_automaton_img!(id)
    render(conn, :show_images, automaton: automaton)
  end

  def update(conn, %{"id" => id, "automaton" => automaton_params}) do
    automaton = Automatons.get_automaton!(id)

    with {:ok, %Automaton{} = automaton} <-
           Automatons.update_automaton(automaton, automaton_params) do
      render(conn, :show, automaton: automaton)
    end
  end

  def delete(conn, %{"id" => id}) do
    automaton = Automatons.get_automaton!(id)

    with {:ok, %Automaton{}} <- Automatons.delete_automaton(automaton) do
      send_resp(conn, :no_content, "")
    end
  end
end
