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

  # ユーザーID、パスワード方式の認証
  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case validate_pass(auth.credentials) do
      :ok ->
        case get_or_create_user(auth) do
          %{ id: _ } = user ->
            IO.puts inspect user
            conn
            |> put_flash(:info, "#{user.uid} としてログインしました")
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

  defp get_or_create_user(auth) do
    Repo.get_by(User, uid: auth.uid, provider: Atom.to_string(auth.provider)) ||
      create_user(%{id: auth.uid, name: auth.info.name, avatar: auth.info.image, email: auth.extra.raw_info["email"], provider: Atom.to_string(auth.provider) })
  end
  defp create_user(params) do
      changeset = User.changeset(%User{}, %{ provider: params[:provider],
                                             uid: params[:id],
                                             name: params[:id],
                                             image_url: "",
                                             email: params[:email],
                                             access_token: "dev"})

      case changeset.valid? && Repo.insert(changeset) do
        {:ok, user} ->
          KakeBosanEx.Item.create_initial_items(user)
          user
        _ ->
          IO.puts inspect changeset
          nil
      end
  end

end
