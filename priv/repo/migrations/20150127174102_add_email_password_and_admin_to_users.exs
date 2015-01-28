defmodule PhoenixCrud.Repo.Migrations.AddEmailPasswordAndAdminToUsers do
  use Ecto.Migration

  def up do
    "ALTER TABLE users ADD COLUMN email varchar(50), ADD COLUMN password varchar(50), ADD COLUMN admin bool"
  end

  def down do
    "ALTER TABLE users DROP COLUMN email, DROP COLUMN password, DROP COLUMN admin"
  end
end
