defmodule PhoenixCrud.Repo.Migrations.RemoveContentFromUsers do
  use Ecto.Migration

  def up do
    "ALTER TABLE users DROP COLUMN content;"
  end

  def down do
    "ALTER TABLE users ADD COLUMN content varchar(140);"
  end
end

