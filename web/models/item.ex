defmodule KakeBosanEx.Item do
  use KakeBosanEx.Web, :model

  schema "items" do
    field :user_id, :integer
    field :name, :string
    field :type_id, :integer
    field :description, :string

    timestamps
  end

  @required_fields ~w(user_id name type_id description)
  @optional_fields ~w()

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
