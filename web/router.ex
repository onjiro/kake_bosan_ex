defmodule KakeBosanEx.Router do
  use KakeBosanEx.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :assign_current_user
  end

  scope "/", KakeBosanEx do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/:any", PageController, :index
    resources "users", UserController
  end

  scope "/auth", KakeBosanEx do
    pipe_through :browser
    get "/", AuthController, :index
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/identity/callback", AuthController, :identity_callback # todo 開発時のみに制限する
  end

  scope "/api", KakeBosanEx do
    pipe_through :api
    resources "transactions",  TransactionController
    resources "inventories",  InventoryController
    resources "items", ItemController
  end

  # Fetch the current user from the session and add it to `conn.assigns`. This
  # will allow you to have access to the current user in your views with
  # `@current_user`.
  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end
