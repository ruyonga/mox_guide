defmodule MoxGuideWeb.PageController do
  use MoxGuideWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
