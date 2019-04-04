defmodule MoxGuide.Repo.Migrations.CreateThings do
  use Ecto.Migration

  def change do
    create table(:things) do
      add :some_attr, :string
      add :another_attr, :string

      timestamps()
    end

  end
end
