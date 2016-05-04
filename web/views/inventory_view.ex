defmodule KakeBosanEx.InventoryView do
  use KakeBosanEx.Web, :view

  alias KakeBosanEx.InventoryView
  alias KakeBosanEx.ItemView

  def render("index.json", %{inventories: inventories}) do
    %{data: render_many(inventories, InventoryView, "inventory.json")}
  end

  def render("show.json", %{inventory: inventory}) do
    %{data: render_one(inventory, InventoryView, "inventory.json")}
  end

  def render("inventory.json", %{inventory: inventory}) do
    %{id: inventory.id,
      item_id: inventory.item_id || inventory.item.id,
      date: inventory.date,
      amount: inventory.amount}
  end
end
