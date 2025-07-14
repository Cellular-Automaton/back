defmodule Back.Images do
  import Ecto.Query, warn: false
  alias Back.Repo
  alias Back.Images.Image

  def list_images_by_algorithm_id(algorithm_id) do
    Image
    |> where([i], i.algorithm_id == ^algorithm_id)
    |> Repo.all()
  end
end
