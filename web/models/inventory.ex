defmodule KakeBosanEx.Inventory do
  use KakeBosanEx.Web, :model

  schema "inventories" do
    field :date, Ecto.Date
    field :amount, :integer
    belongs_to :item, KakeBosanEx.Item

    timestamps
  end

  @required_fields ~w(date amount)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
