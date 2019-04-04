defmodule MoxGuideWeb.ThingController do
  use MoxGuideWeb, :controller

  alias MoxGuide.AllTheThings
  alias MoxGuide.AllTheThings.Thing

  action_fallback MoxGuideWeb.FallbackController

  def index(conn, _params) do
    things = AllTheThings.list_things()
    render(conn, "index.json", things: things)
  end

  def create(conn, %{"thing" => thing_params}) do
    with {:ok, %Thing{} = thing} <- AllTheThings.create_thing(thing_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.thing_path(conn, :show, thing))
      |> render("show.json", thing: thing)
    end
  end

  def show(conn, %{"id" => id}) do
    thing = AllTheThings.get_thing!(id)
    render(conn, "show.json", thing: thing)
  end

  def update(conn, %{"id" => id, "thing" => thing_params}) do
    thing = AllTheThings.get_thing!(id)

    with {:ok, %Thing{} = thing} <- AllTheThings.update_thing(thing, thing_params) do
      render(conn, "show.json", thing: thing)
    end
  end

  def delete(conn, %{"id" => id}) do
    thing = AllTheThings.get_thing!(id)

    with {:ok, %Thing{}} <- AllTheThings.delete_thing(thing) do
      send_resp(conn, :no_content, "")
    end
  end
end
