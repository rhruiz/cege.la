defmodule CegelaTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Cegela.Server
  alias Plug.Conn

  doctest Cegela

  test "redirects to bit.ly" do
    conn =
      :get
      |> conn("/something?query=x")
      |> Server.call([])

    assert 302 = conn.status
    assert ["https://bit.ly/something?query=x"] = get_resp_header(conn, "location")
  end

  test "there is no favicon" do
    assert %Conn{status: 404} =
             :get
             |> conn("/favicon.ico")
             |> Server.call(%{})
  end
end
