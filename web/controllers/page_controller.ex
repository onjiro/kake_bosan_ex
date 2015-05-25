defmodule KakeBosanEx.PageController do
  use KakeBosanEx.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
