defmodule Back.Automatons do
  @moduledoc """
  The Automatons context.
  """

  import Ecto.Query, warn: false
  alias Back.Repo

  alias Back.Automatons.Automaton
  alias Back.Data.Image.Images
  alias Back.Data.Image
  alias Back.Data.Files.File

  @doc """
  Returns the list of automaton.

  ## Examples

      iex> list_automaton()
      [%Automaton{}, ...]

  """
  def list_automaton do
    Repo.all(Automaton)
  end

  @doc """
  Gets all automaton with their image field preloaded


  ## Examples

      iex> list_automaton_with_img()
      [%Automaton{:image: [], ...}, ...]
  """
  def list_automaton_with_img do
    Repo.all(Automaton) |> Repo.preload([:image, :file])
  end

  @doc """
  Gets a single automaton.

  Raises `Ecto.NoResultsError` if the Automaton does not exist.

  ## Examples

      iex> get_automaton!(123)
      %Automaton{}

      iex> get_automaton!(456)
      ** (Ecto.NoResultsError)

  """
  def get_automaton!(id), do: Repo.get!(Automaton, id)

  def get_automaton_img!(id) do
    Repo.get!(Automaton, id) |> Repo.preload([:image, :file])
  end

  @doc """
  Creates a automaton.

  ## Examples

      iex> create_automaton(%{field: value})
      {:ok, %Automaton{}}

      iex> create_automaton(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_automaton(attrs \\ %{}) do
    auto =
      %Automaton{}
      |> Automaton.changeset(attrs)
      |> Repo.insert()

    if elem(auto, 0) == :ok do
      content = elem(auto, 1)

      if attrs["image"] != nil do
        for automaton <- attrs["image"] do
          %Images{}
          |> Images.changeset(Map.put(automaton, "automaton_id", content.automaton_id))
          |> Repo.insert()
        end
      end

      if attrs["file"] != nil do
        for file <- attrs["file"] do
          %File{}
          |> File.changeset(Map.put(file, "automaton_id", content.automaton_id))
          |> Repo.insert()
        end
      end
    end

    auto
  end

  @doc """
  Updates a automaton.

  ## Examples

      iex> update_automaton(automaton, %{field: new_value})
      {:ok, %Automaton{}}

      iex> update_automaton(automaton, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_automaton(%Automaton{} = automaton, attrs) do
    if attrs["image"] != nil do
      to_del = Image.get_image_automaton_id(automaton.automaton_id)
      Enum.map(to_del, fn del -> Image.delete_images(del) end)

      for automaton <- attrs["image"] do
        %Images{}
        |> Images.changeset(Map.put(automaton, "automaton_id", automaton.automaton_id))
        |> Repo.insert()
      end
    end

    if attrs["file"] != nil do
      for file <- attrs["file"] do
        %File{}
        |> File.changeset(Map.put(file, "automaton_id", automaton.automaton_id))
        |> Repo.insert()
      end
    end

    automaton
    |> Automaton.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a automaton.

  ## Examples

      iex> delete_automaton(automaton)
      {:ok, %Automaton{}}

      iex> delete_automaton(automaton)
      {:error, %Ecto.Changeset{}}

  """
  def delete_automaton(%Automaton{} = automaton) do
    Repo.delete(automaton)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking automaton changes.

  ## Examples

      iex> change_automaton(automaton)
      %Ecto.Changeset{data: %Automaton{}}

  """
  def change_automaton(%Automaton{} = automaton, attrs \\ %{}) do
    Automaton.changeset(automaton, attrs)
  end

  def get_recents!(nb) do
    query = from a in Automaton, order_by: [asc: a.inserted_at], limit: ^nb

    Repo.all(query) |> Repo.preload([:image, :file])
  end
end
