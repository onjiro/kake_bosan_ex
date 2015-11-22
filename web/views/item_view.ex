defmodule KakeBosanEx.ItemView do
  use KakeBosanEx.Web, :view

  alias KakeBosanEx.ItemView

  def render("index.json", %{items: items}) do
    %{data: render_many(items, ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("item.json", %{item: item}) do
    %{id: item.id,
      name: item.name,
      type_id: item.type_id,
      description: item.description}
  end
end
