defmodule HeliosWeb.HelloController do
  use HeliosWeb, :controller

  def index(conn, _params) do
    
    render(conn, "index.html")
  end
end
