defmodule KakeBosanEx.AuthController do
  use KakeBosanEx.Web, :controller

  plug :action

  @doc """
  This action is reached via `/auth` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, _params) do
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
    |> redirect(to: "/")
  end
end
