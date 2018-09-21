defmodule VocialWeb.PageControllerTest do
  use VocialWeb.ConnCase

  test "GET /", %{conn: conn} do
    #get the conn
    conn = get conn, "/"
    #if html_response assert "Welcome to Phoenix" -> response 200
    assert html_response(conn, 200)
  end
end
