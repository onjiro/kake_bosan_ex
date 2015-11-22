defmodule KakeBosanEx.EntryView do
  use KakeBosanEx.Web, :view

  alias KakeBosanEx.EntryView

  def render("index.json", %{entries: entries}) do
    %{data: render_many(entries, EntryView, "entry.json")}
  end

  def render("show.json", %{entry: entry}) do
    %{data: render_one(entry, EntryView, "entry.json")}
  end

  def render("entry.json", %{entry: entry}) do
    %{id: entry.id,
      side_id: entry.side_id,
      amount: entry.amount,
      item_id: entry.item_id,
      item: render_one(entry.item, ItemView, "item.json")}
  end
end
