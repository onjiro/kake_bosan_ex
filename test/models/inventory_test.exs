defmodule KakeBosanEx.InventoryTest do
  use KakeBosanEx.ModelCase

  alias KakeBosanEx.Inventory

  @valid_attrs %{amount: 42, date: "2010-04-17"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Inventory.changeset(%Inventory{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Inventory.changeset(%Inventory{}, @invalid_attrs)
    refute changeset.valid?
  end
end
