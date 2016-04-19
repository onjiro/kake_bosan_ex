require Logger
# 棚卸の記録
defmodule KakeBosanEx.Inventory do
  use KakeBosanEx.Web, :model
  alias KakeBosanEx.Inventory
  alias KakeBosanEx.Item
  alias KakeBosanEx.Entry
  alias KakeBosanEx.Transaction
  alias KakeBosanEx.Repo

  schema "inventories" do
    field :date, Ecto.Date
    field :amount, :integer

    belongs_to :item, Item
    has_one :transaction, Transaction # 棚卸差額調整がある場合がある

    timestamps
  end

  @required_fields ~w(item_id date amount)
  @optional_fields ~w()

  after_insert :create_adjustment_transaction
  after_update :create_adjustment_transaction
  after_delete :delete_adjustment_transaction

  @doc """
  指定された勘定科目について指定日時点の棚卸高を計算する
  """
  def calculate(item_query, at \\ Ecto.DateTime.utc) do
    result = Repo.all(
      from item in item_query,
      left_join: entry in assoc(item, :entries),
      left_join: trx in assoc(entry, :transaction),
      # LEFT JOIN の結合条件に変換する
      # where: trx.date <= ^at,
      order_by: [item.type_id, item.id],
      group_by: [item.type_id, item.id],
      select: %{
        item: item,
        debit_amount:  fragment("COALESCE(SUM(CASE WHEN ? = ? THEN amount END), ?)", entry.side_id, 1, 0),
        credit_amount: fragment("COALESCE(SUM(CASE WHEN ? = ? THEN amount END), ?)", entry.side_id, 2, 0),
        offset_amount: fragment("COALESCE(SUM(CASE WHEN ? = (CASE ? WHEN 1 THEN 1 WHEN 2 THEN 1 ELSE 2 END) THEN amount ELSE -amount END), ?)", entry.side_id, item.type_id, 0),
      }
    )

    Logger.debug(inspect(result))

    result
  end

  @doc """
  棚卸差額調整のための取引を作成するコールバック関数

  棚卸記録が作成、もしくは更新された場合に該当科目の金額を調整する。
  すでに棚卸記録が存在する場合に、取引が作成、更新、削除された場合の調整は todo にて行う。
  """
  defp create_adjustment_transaction(inventory) do
    # transaction がなければ作成する、あれば更新する
  end

  @doc """
  棚卸差額調整のための取引を削除するコールバック関数
  """
  defp delete_adjustment_transaction(inventory) do
    case inventory.transaction_id do
      is_number ->
        Repo.get!(KakeBosanEx.Transaction, inventory.transaction_id)
        |> Repo.delete!
    end
  end

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
