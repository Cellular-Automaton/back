defmodule Back.Data.FilesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Data.Files` context.
  """

  @doc """
  Generate a file.
  """
  def file_fixture(attrs \\ %{}) do
    {:ok, file} =
      attrs
      |> Enum.into(%{
        contents: "some contents",
        name: "some name"
      })
      |> Back.Data.Files.create_file()

    file
  end
end
