defmodule BackWeb.AutomatonController do
  use BackWeb, :controller

  alias Back.Automatons
  alias Back.Automatons.Automaton
  alias Back.Automatons.AutomatonTags
  alias Back.Data.{Files, Image}

  action_fallback BackWeb.FallbackController

  def index(conn, _params) do
    automaton = Automatons.list_automaton()

    automaton_with_tags =
      Enum.map(automaton, fn automaton ->
        tags = AutomatonTags.get_tags_by_automaton_id!(automaton.automaton_id)
        image_result = Image.get_image_automaton_id(automaton.automaton_id)

        image =
          case image_result do
            {:ok, img} -> img
            {:none, _} -> nil
            other -> other
          end

        automaton
        |> Map.put(:tags, tags)
        |> Map.put(:image, image)
      end)

    render(conn, :index, automaton: automaton_with_tags)
  end

  def index_img(conn, _params) do
    automatons = Automatons.list_automaton_with_img()

    automatons_tags =
      for automaton <- automatons do
        tags = AutomatonTags.get_tags_by_automaton_id!(automaton.automaton_id)
        Map.put(automaton, :tags, tags)
      end

    render(conn, :index_image, automaton: automatons_tags)
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
    images =
      case Map.get(automaton_params, "image") do
        %{} = map -> Map.values(map)
        list when is_list(list) -> list
        %Plug.Upload{} = upload -> [upload]
        _ -> []
      end
      |> decode_base64_fields()

    files =
      case Map.get(automaton_params, "file") do
        %{} = map -> Map.values(map)
        list when is_list(list) -> list
        %Plug.Upload{} = upload -> [upload]
        _ -> []
      end
      |> decode_base64_fields()

    automaton_params =
      automaton_params
      |> Map.put("image", images)
      |> Map.put("file", files)

    with {:ok, %Automaton{} = automaton} <- Automatons.create_automaton(automaton_params) do
      {res, img} = Image.get_image_automaton_id(automaton.automaton_id)
      {resf, files} = Files.get_file_automaton_id(automaton.automaton_id)

      automaton =
        if res == :ok do
          Map.put(automaton, :image, img)
        else
          automaton
        end

      automaton =
        if resf == :ok do
          Map.put(automaton, :file, files)
        else
          automaton
        end

      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/automaton/#{automaton.automaton_id}")
      |> render(:show_images, automaton: automaton, tags: [])
    end
  end

  def show(conn, %{"id" => id}) do
    automaton = Automatons.get_automaton!(id)
    render(conn, :show, automaton: automaton)
  end

  def show_img(conn, %{"id" => id}) do
    automaton = Automatons.get_automaton_img!(id)
    tags = AutomatonTags.get_tags_by_automaton_id!(id)

    render(conn, :show_images, automaton: automaton, tags: tags)
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

  def get_recents(conn, %{"nb" => nb}) do
    automaton = Automatons.get_recents!(nb)
    render(conn, :index_date, automaton: automaton)
  end

  def get_files(conn, %{"id" => id}) do
    automaton = Automatons.get_automaton!(id)
    files = Files.get_file_automaton_id(automaton.automaton_id)

    case files do
      {:ok, file} ->
        render(conn, :show_files, automaton: automaton, files: file)

      {:none, _} ->
        render(conn, :show_files, automaton: automaton, files: [])
    end
  end

  defp decode_base64_fields(list) when is_list(list) do
    Enum.map(list, fn item ->
      case Map.get(item, "data") do
        nil ->
          item

        base64 ->
          {:ok, binary} = Base.decode64(base64)
          Map.put(item, "data", binary)
      end
    end)
  end

  defp decode_base64_fields(_), do: []
end
