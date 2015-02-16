defmodule LambdaDays.Repo.Migrations.CreateTalks do
  use Ecto.Migration

  def up do
    "CREATE TABLE talks(id serial primary key,\
      title varchar(140),\
      description varchar(1000),\
      plus_votes integer,\
      zero_votes integer,\
      minus_votes integer)"
  end

  def down do
    "DROP TABLE talks"
  end
end
