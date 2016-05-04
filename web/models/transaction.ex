defmodule KakeBosanEx.Transaction do
  use KakeBosanEx.Web, :model

  schema "transactions" do
    field :date, Ecto.DateTime
    field :description, :string

    belongs_to :user, KakeBosanEx.User
    has_many :entries, KakeBosanEx.Entry, on_delete: :delete_all

    timestamps
  end

  @required_fields ~w(user_id date entries)
  @optional_fields ~w(description)

  after_insert :update_immediate_inventory_adjustment_transaction
  after_update :update_immediate_inventory_adjustment_transaction
  after_delete :update_immediate_inventory_adjustment_transaction
  #after_delete :delete_entries

  @doc """
  直近の棚卸額調整のための取引の金額を更新するコールバック関数

  棚卸記録を調整した場合の調整は Inventory 側で実施する。
  """
  defp update_immediate_inventory_adjustment_transaction(transaction_changeset) do
    # todo
    transaction_changeset
  end

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
