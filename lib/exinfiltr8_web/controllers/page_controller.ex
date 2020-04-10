defmodule Exinfiltr8Web.PageController do
  use Exinfiltr8Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
