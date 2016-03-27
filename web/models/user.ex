defmodule KakeBosanEx.User do
  use KakeBosanEx.Web, :model
  alias KakeBosanEx.User
  alias KakeBosanEx.Repo
  require Logger

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
  ueberauth 由でのユーザー作成
  """
  def create_with_ueberauth(%{provider: :identity, info: info, uid: uid} = auth) do
    Logger.info("create_with_ueberauth #{inspect auth}")
    changeset(%User{}, %{ provider: "identity", uid: uid, name: info.nickname, access_token: "",
                          image_url: info.image || "", email: info.email || ""})
    |> create_new_user
  end
  def create_with_ueberauth(%{provider: :twitter, info: info, uid: uid} = auth) do
    Logger.info("create_with_ueberauth #{inspect auth}")
    changeset(%User{}, %{ provider: "twitter", uid: uid, name: info.name, access_token: "",
                          image_url: info.image || "", email: info.email || ""})
    |> create_new_user
  end
  def create_with_ueberauth(%{provider: provider, info: info, uid: uid} = auth) do
    Logger.info("create_with_ueberauth #{inspect auth}")
    changeset(%User{}, %{ provider: Atom.to_string(provider), uid: uid, name: info.name, access_token: "",
                          image_url: info.image || "", email: info.email} || "")
    |> create_new_user
  end

  defp create_new_user(changeset) do
    case changeset.valid? && Repo.insert(changeset) do
      {:ok, user} ->
        KakeBosanEx.Item.create_initial_items(user)
        user
      false ->
        Logger.warn("Validation error! #{inspect changeset.errors}")
        nil
    end
  end


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
