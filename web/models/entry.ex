defmodule KakeBosanEx.Entry do
  use KakeBosanEx.Web, :model

  schema "entries" do
    field :side_id, :integer
    field :amount, :integer

    belongs_to :user, KekeBosanEx.User
    belongs_to :transaction, KakeBosanEx.Transaction
    belongs_to :item, KakeBosanEx.Item

    timestamps
  end

  @required_fields ~w(user_id side_id item_id amount)
  @optional_fields ~w(transaction_id)

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
