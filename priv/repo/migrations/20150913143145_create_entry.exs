defmodule KakeBosanEx.Repo.Migrations.CreateEntry do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :user_id, references(:users)
      add :transaction_id, references(:transactions)
      add :side_id, :integer
      add :item_id, :integer
      add :amount, :integer

      timestamps
    end
    create index(:entries, [:user_id, :item_id, :side_id])
    create index(:entries, [:transaction_id])
    create index(:entries, [:side_id])
    create index(:entries, [:item_id])
  end
end
