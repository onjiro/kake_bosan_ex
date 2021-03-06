defmodule KakeBosanEx.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :provider, :string
      add :uid, :string
      add :name, :string
      add :image_url, :string
      add :email, :string
      add :access_token, :string

      timestamps
    end
    create index(:users, [:provider, :uid], unique: true)
  end
end
