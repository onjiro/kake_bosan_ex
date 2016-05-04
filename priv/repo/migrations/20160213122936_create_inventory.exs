defmodule KakeBosanEx.Repo.Migrations.CreateInventory do
  use Ecto.Migration

  def change do
    create table(:inventories) do
      add :date, :date
      add :amount, :integer
      add :item_id, references(:items)

      timestamps
    end
    create index(:inventories, [:item_id])

  end
end
