defmodule KakeBosanEx.Transaction do
  use KakeBosanEx.Web, :model

  schema "transactions" do
    field :date, Ecto.DateTime
    field :description, :string

    belongs_to :user, HelloPhoenix.User, foreign_key: :user_id

    timestamps
  end

  @required_fields ~w(user_id date)
  @optional_fields ~w(description)

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