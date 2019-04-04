defmodule MoxGuide.AllTheThings.Thing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "things" do
    field :another_attr, :string
    field :some_attr, :string

    timestamps()
  end

  @doc false
  def changeset(thing, attrs) do
    thing
    |> cast(attrs, [:some_attr, :another_attr])
    |> validate_required([:some_attr, :another_attr])
  end
end
