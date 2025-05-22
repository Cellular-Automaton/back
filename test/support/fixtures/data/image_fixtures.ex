defmodule Back.Data.ImageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Data.Image` context.
  """

  @doc """
  Generate a images.
  """
  def images_fixture(attrs \\ %{}) do
    {:ok, images} =
      attrs
      |> Enum.into(%{
        contents_binary: "some contents_binary",
        contents_type: "some contents_type"
      })
      |> Back.Data.Image.create_images()

    images
  end
end
