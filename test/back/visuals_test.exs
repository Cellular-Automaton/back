defmodule Back.VisualsTest do
  use Back.DataCase

  alias Back.Visuals

  describe "visuals" do
    alias Back.Visuals.Visual

    import Back.VisualsFixtures

    @invalid_attrs %{name: nil, description: nil, assets_link: nil}

    test "list_visuals/0 returns all visuals" do
      visual = visual_fixture()
      assert Visuals.list_visuals() == [visual]
    end

    test "get_visual!/1 returns the visual with given id" do
      visual = visual_fixture()
      assert Visuals.get_visual!(visual.id) == visual
    end

    test "create_visual/1 with valid data creates a visual" do
      valid_attrs = %{
        name: "some name",
        description: "some description",
        assets_link: "some assets_link"
      }

      assert {:ok, %Visual{} = visual} = Visuals.create_visual(valid_attrs)
      assert visual.name == "some name"
      assert visual.description == "some description"
      assert visual.assets_link == "some assets_link"
    end

    test "create_visual/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Visuals.create_visual(@invalid_attrs)
    end

    test "update_visual/2 with valid data updates the visual" do
      visual = visual_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        assets_link: "some updated assets_link"
      }

      assert {:ok, %Visual{} = visual} = Visuals.update_visual(visual, update_attrs)
      assert visual.name == "some updated name"
      assert visual.description == "some updated description"
      assert visual.assets_link == "some updated assets_link"
    end

    test "update_visual/2 with invalid data returns error changeset" do
      visual = visual_fixture()
      assert {:error, %Ecto.Changeset{}} = Visuals.update_visual(visual, @invalid_attrs)
      assert visual == Visuals.get_visual!(visual.id)
    end

    test "delete_visual/1 deletes the visual" do
      visual = visual_fixture()
      assert {:ok, %Visual{}} = Visuals.delete_visual(visual)
      assert_raise Ecto.NoResultsError, fn -> Visuals.get_visual!(visual.id) end
    end

    test "change_visual/1 returns a visual changeset" do
      visual = visual_fixture()
      assert %Ecto.Changeset{} = Visuals.change_visual(visual)
    end
  end
end
