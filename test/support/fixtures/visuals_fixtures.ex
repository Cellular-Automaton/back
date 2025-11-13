defmodule Back.VisualsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Visuals` context.
  """

  @doc """
  Generate a visual.
  """
  def visual_fixture(attrs \\ %{}) do
    {:ok, visual} =
      attrs
      |> Enum.into(%{
        assets_link: "some assets_link",
        description: "some description",
        name: "some name"
      })
      |> Back.Visuals.create_visual()

    visual
  end
end
