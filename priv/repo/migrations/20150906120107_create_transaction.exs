defmodule KakeBosanEx.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :user_id, references(:users)
      add :date, :datetime
      add :description, :string

      timestamps
    end
    create index(:transactions, [:user_id, :date])
  end
end
