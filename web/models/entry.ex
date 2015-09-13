defmodule KakeBosanEx.Entry do
  use KakeBosanEx.Web, :model

  schema "entries" do
    field :user_id, :integer
    field :transaction_id, :integer
    field :side_id, :integer
    field :item_id, :integer
    field :amount, :integer

    timestamps
  end

  @required_fields ~w(user_id transaction_id side_id item_id amount)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
