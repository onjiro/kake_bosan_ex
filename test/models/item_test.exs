defmodule KakeBosanEx.ItemTest do
  use KakeBosanEx.ModelCase

  alias KakeBosanEx.Item

  @valid_attrs %{description: "some content", name: "some content", type_id: 42, user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Item.changeset(%Item{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Item.changeset(%Item{}, @invalid_attrs)
    refute changeset.valid?
  end
end
