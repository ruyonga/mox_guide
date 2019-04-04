defmodule MoxGuide.UsersTest do
  use MoxGuide.DataCase

  alias MoxGuide.Users

  describe "users" do
    alias MoxGuide.Users.User

    @valid_attrs %{bio: "some bio", email: "some@email.com", name: "some name", number_of_pets: 42}
    @update_attrs %{
      bio: "some updated bio",
      email: "some@email.com",
      name: "some updated name",
      number_of_pets: 43
    }
    @invalid_attrs %{bio: nil, email: nil, name: nil, number_of_pets: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.bio == "some bio"
      assert user.email == "some@email.com"
      assert user.name == "some name"
      assert user.number_of_pets == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.bio == "some updated bio"
      assert user.email == "some@email.com"
      assert user.name == "some updated name"
      assert user.number_of_pets == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end

    test "number of pets is optional" do
      changest = User.changeset(%User{}, Map.delete(@valid_attrs, :number_of_pets))
      assert changest.valid?
    end

    test "bio must be at least two characters long" do
      attrs = %{@valid_attrs | bio: "I"}
      changeset = User.changeset(%User{}, attrs)
      assert %{bio: ["should be at least 2 character(s)"]} = errors_on(changeset)
    end

    test "bio must be at most 140 characters long" do
      attrs = %{@valid_attrs | bio: String.duplicate("a", 141)}
      changeset = User.changeset(%User{}, attrs)
      assert %{bio: ["should be at most 140 character(s)"]} = errors_on(changeset)
    end

    test "email must contain at least @" do
      attrs = %{@valid_attrs | email: "fooexampla.com"}
      changeset = User.changeset(%User{}, attrs)
      assert %{email: ["has invalid format"]} = errors_on(changeset)
    end
  end
end
