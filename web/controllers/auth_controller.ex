defmodule KakeBosanEx.AuthController do
  use KakeBosanEx.Web, :controller
  alias KakeBosanEx.User
  alias Ueberauth.Auth
  alias Ueberauth.Strategy.Helpers
  plug Ueberauth

  @doc """
  This action is reached via `/auth` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, _params) do
    redirect conn, external: GitHub.authorize_url!
  end

  # 認証リクエスト
  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  # 通常の oauth 認証
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case get_or_create_user(auth) do
      %{ id: _ } = user ->
        conn
        |> put_flash(:info, "#{user.name} としてログインしました")
        |> put_session(:current_user, user)
        |> redirect(to: "/dashboard")
      _ ->
        conn
        |> put_flash(:error, "ユーザー作成に失敗しました")
        |> redirect(to: "/")
    end
  end

  # ユーザーID、パスワード方式の認証
  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case validate_pass(auth.credentials) do
      :ok ->
        case get_or_create_user(auth) do
          %{ id: _ } = user ->
            conn
            |> put_flash(:info, "#{user.name} としてログインしました")
            |> put_session(:current_user, user)
            |> redirect(to: "/dashboard")
          _ ->
            conn
            |> put_flash(:error, "ユーザー作成に失敗しました")
            |> redirect(to: "/")
        end
      { :error, reason } ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  defp validate_pass(%{other: %{password: ""}}) do
    {:error, "Password required"}
  end
  defp validate_pass(%{other: %{password: pw, password_confirmation: pw}}) do
    :ok
  end
  defp validate_pass(%{other: %{password: _}}) do
    {:error, "Passwords do not match"}
  end
  defp validate_pass(_), do: {:error, "Password Required"}

  defp get_or_create_user(%{ uid: uid, provider: provider } = auth) do
    Repo.get_by(User, uid: uid, provider: Atom.to_string(provider)) || User.create_with_ueberauth(auth)
  end
end
