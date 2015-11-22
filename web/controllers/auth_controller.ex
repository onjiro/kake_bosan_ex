defmodule KakeBosanEx.AuthController do
  use KakeBosanEx.Web, :controller
  alias KakeBosanEx.User

  @doc """
  This action is reached via `/auth` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, _params) do
    redirect conn, external: GitHub.authorize_url!
  end

  def dev(conn, params) do
    user = Repo.get_by(User, provider: "dev", uid: params["uid"] || "development_user") ||
      create_user(params)

    conn
    |> put_session(:current_user_id, user.id)
    |> redirect(to: "/dashboard")
  end

  def create_user(params) do
      changeset = User.changeset(%User{}, %{ provider: "dev",
                                             uid: params["uid"] || "development_user",
                                             name: params["name"] || "development_user",
                                             image_url: "",
                                             email: "",
                                             access_token: "dev"})

      case changeset.valid? && Repo.insert(changeset) do
        {:ok, user} ->
          KakeBosanEx.Item.create_initial_items(user)
          user
      end
  end

  def github(conn, _params) do
    redirect conn, external: GitHub.authorize_url!
  end

  @doc """
  This action is reached via `/auth/github/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback_for_github(conn, %{"code" => code}) do
    token = GitHub.get_token!(code: code)
    user = OAuth2.AccessToken.get!(token, "/user")

    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, token.access_token)
    |> redirect(to: "/dashboard")
  end
end
