defmodule MoxGuideWeb.ThingView do
  use MoxGuideWeb, :view
  alias MoxGuideWeb.ThingView

  def render("index.json", %{things: things}) do
    %{data: render_many(things, ThingView, "thing.json")}
  end

  def render("show.json", %{thing: thing}) do
    %{data: render_one(thing, ThingView, "thing.json")}
  end

  def render("thing.json", %{thing: thing}) do
    %{id: thing.id,
      some_attr: thing.some_attr,
      another_attr: thing.another_attr}
  end
end
