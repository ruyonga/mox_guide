defmodule MoxGuide.AllTheThingsTest do
  use MoxGuide.DataCase

  alias MoxGuide.AllTheThings

  describe "things" do
    alias MoxGuide.AllTheThings.Thing

    @valid_attrs %{another_attr: "some another_attr", some_attr: "some some_attr"}
    @update_attrs %{another_attr: "some updated another_attr", some_attr: "some updated some_attr"}
    @invalid_attrs %{another_attr: nil, some_attr: nil}

    def thing_fixture(attrs \\ %{}) do
      {:ok, thing} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AllTheThings.create_thing()

      thing
    end

    test "list_things/0 returns all things" do
      thing = thing_fixture()
      assert AllTheThings.list_things() == [thing]
    end

    test "get_thing!/1 returns the thing with given id" do
      thing = thing_fixture()
      assert AllTheThings.get_thing!(thing.id) == thing
    end

    test "create_thing/1 with valid data creates a thing" do
      assert {:ok, %Thing{} = thing} = AllTheThings.create_thing(@valid_attrs)
      assert thing.another_attr == "some another_attr"
      assert thing.some_attr == "some some_attr"
    end

    test "create_thing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AllTheThings.create_thing(@invalid_attrs)
    end

    test "update_thing/2 with valid data updates the thing" do
      thing = thing_fixture()
      assert {:ok, %Thing{} = thing} = AllTheThings.update_thing(thing, @update_attrs)
      assert thing.another_attr == "some updated another_attr"
      assert thing.some_attr == "some updated some_attr"
    end

    test "update_thing/2 with invalid data returns error changeset" do
      thing = thing_fixture()
      assert {:error, %Ecto.Changeset{}} = AllTheThings.update_thing(thing, @invalid_attrs)
      assert thing == AllTheThings.get_thing!(thing.id)
    end

    test "delete_thing/1 deletes the thing" do
      thing = thing_fixture()
      assert {:ok, %Thing{}} = AllTheThings.delete_thing(thing)
      assert_raise Ecto.NoResultsError, fn -> AllTheThings.get_thing!(thing.id) end
    end

    test "change_thing/1 returns a thing changeset" do
      thing = thing_fixture()
      assert %Ecto.Changeset{} = AllTheThings.change_thing(thing)
    end
  end
end
