defmodule KakeBosanEx.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :user_id, :integer
      add :name, :string
      add :type_id, :integer
      add :description, :string

      timestamps
    end
    create index(:items, [:user_id])
    create index(:items, [:type_id])
  end
end
