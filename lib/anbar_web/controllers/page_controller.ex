defmodule AnbarWeb.PageController do
  use AnbarWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
