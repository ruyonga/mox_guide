defmodule MoxGuideWeb.UserControllerTest do
  use MoxGuideWeb.ConnCase

  alias MoxGuide.Users

  @create_attrs %{bio: "some bio", email: "some@email.com", name: "some name", number_of_pets: 42}
  @update_attrs %{
    bio: "some updated bio",
    email: "some@email.com",
    name: "some updated name",
    number_of_pets: 43
  }
  @invalid_attrs %{bio: nil, email: nil, name: nil, number_of_pets: nil}

  def fixture(:user) do
    {:ok, user} = Users.create_user(@create_attrs)
    user
  end

  test "index/2 responds with all  Users", %{conn: conn} do
          users = [%{bio: "some bio", email: "some@email.com", name: "some name", number_of_pets: 42},%{bio: "some bio", email: "some@email.com", name: "some name", number_of_pets: 42}]
          [{:ok, user1}, {:ok, user2}] = Enum.map(users, &Users.create_user(&1))

          response =
            conn
              |> get(Routes.user_path(conn, :index))
              |> json_response(200)

              expected = %{
                "data" => [
                  %{ "name" => user1.bio, "email" => user1.email, "name" => user1.name, "number_of_pets" => user1.number_of_pets },
                  %{ "name" => user1.bio, "email" => user1.email, "name" => user1.name, "number_of_pets" => user1.number_of_pets}
                ]
              }
      assert response == expected
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
