defmodule KakeBosanEx.TransactionTest do
  use KakeBosanEx.ModelCase

  alias KakeBosanEx.Transaction

  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, description: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Transaction.changeset(%Transaction{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Transaction.changeset(%Transaction{}, @invalid_attrs)
    refute changeset.valid?
  end
end
