defmodule Back.Plugins.ManagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Back.Plugins.Manager` context.
  """

  @doc """
  Generate a plugin_manager.
  """
  def plugin_manager_fixture(attrs \\ %{}) do
    {:ok, plugin_manager} =
      attrs
      |> Enum.into(%{})
      |> Back.Plugins.Manager.create_plugin_manager()

    plugin_manager
  end
end
