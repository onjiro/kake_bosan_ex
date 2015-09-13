defmodule KakeBosanEx.EntryTest do
  use KakeBosanEx.ModelCase

  alias KakeBosanEx.Entry

  @valid_attrs %{amount: 42, item_id: 42, side_id: 42, transaction_id: 42, user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Entry.changeset(%Entry{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Entry.changeset(%Entry{}, @invalid_attrs)
    refute changeset.valid?
  end
end
