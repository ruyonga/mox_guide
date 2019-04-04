defmodule MoxGuideWeb.ThingControllerTest do
  use MoxGuideWeb.ConnCase

  alias MoxGuide.AllTheThings
  alias MoxGuide.AllTheThings.Thing

  @create_attrs %{
    another_attr: "some another_attr",
    some_attr: "some some_attr"
  }
  @update_attrs %{
    another_attr: "some updated another_attr",
    some_attr: "some updated some_attr"
  }
  @invalid_attrs %{another_attr: nil, some_attr: nil}

  def fixture(:thing) do
    {:ok, thing} = AllTheThings.create_thing(@create_attrs)
    thing
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all things", %{conn: conn} do
      conn = get(conn, Routes.thing_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create thing" do
    test "renders thing when data is valid", %{conn: conn} do
      conn = post(conn, Routes.thing_path(conn, :create), thing: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.thing_path(conn, :show, id))

      assert %{
               "id" => id,
               "another_attr" => "some another_attr",
               "some_attr" => "some some_attr"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.thing_path(conn, :create), thing: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update thing" do
    setup [:create_thing]

    test "renders thing when data is valid", %{conn: conn, thing: %Thing{id: id} = thing} do
      conn = put(conn, Routes.thing_path(conn, :update, thing), thing: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.thing_path(conn, :show, id))

      assert %{
               "id" => id,
               "another_attr" => "some updated another_attr",
               "some_attr" => "some updated some_attr"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, thing: thing} do
      conn = put(conn, Routes.thing_path(conn, :update, thing), thing: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete thing" do
    setup [:create_thing]

    test "deletes chosen thing", %{conn: conn, thing: thing} do
      conn = delete(conn, Routes.thing_path(conn, :delete, thing))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.thing_path(conn, :show, thing))
      end
    end
  end

  defp create_thing(_) do
    thing = fixture(:thing)
    {:ok, thing: thing}
  end
end
