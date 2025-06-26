defmodule Back.Data.ImageTest do
  use Back.DataCase

  alias Back.Data.Image

  describe "image" do
    alias Back.Data.Image.Images

    import Back.Data.ImageFixtures

    @invalid_attrs %{contents_binary: nil, contents_type: nil}

    test "list_image/0 returns all image" do
      images = images_fixture()
      assert Image.list_image() == [images]
    end

    test "get_images!/1 returns the images with given id" do
      images = images_fixture()
      assert Image.get_images!(images.id) == images
    end

    test "create_images/1 with valid data creates a images" do
      valid_attrs = %{
        contents_binary: "some contents_binary",
        contents_type: "some contents_type"
      }

      assert {:ok, %Images{} = images} = Image.create_images(valid_attrs)
      assert images.contents_binary == "some contents_binary"
      assert images.contents_type == "some contents_type"
    end

    test "create_images/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Image.create_images(@invalid_attrs)
    end

    test "update_images/2 with valid data updates the images" do
      images = images_fixture()

      update_attrs = %{
        contents_binary: "some updated contents_binary",
        contents_type: "some updated contents_type"
      }

      assert {:ok, %Images{} = images} = Image.update_images(images, update_attrs)
      assert images.contents_binary == "some updated contents_binary"
      assert images.contents_type == "some updated contents_type"
    end

    test "update_images/2 with invalid data returns error changeset" do
      images = images_fixture()
      assert {:error, %Ecto.Changeset{}} = Image.update_images(images, @invalid_attrs)
      assert images == Image.get_images!(images.id)
    end

    test "delete_images/1 deletes the images" do
      images = images_fixture()
      assert {:ok, %Images{}} = Image.delete_images(images)
      assert_raise Ecto.NoResultsError, fn -> Image.get_images!(images.id) end
    end

    test "change_images/1 returns a images changeset" do
      images = images_fixture()
      assert %Ecto.Changeset{} = Image.change_images(images)
    end
  end
end
