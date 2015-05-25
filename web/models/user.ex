defmodule KakeBosanEx.User do
  use KakeBosanEx.Web, :model

  schema "users" do
    field :provider, :string
    field :uid, :string
    field :name, :string
    field :image_url, :string
    field :email, :string
    field :access_token, :string

    timestamps
  end

  @required_fields ~w(provider uid name image_url email access_token)
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
