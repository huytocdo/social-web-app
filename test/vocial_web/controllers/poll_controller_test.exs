defmodule VocialWeb.PollControllerTest do
  use VocialWeb.ConnCase

  alias Vocial.Votes

  setup do 
    conn = build_conn()
    {:ok, user} = Vocial.Accounts.create_user(%{
      username: "test",
      email: "test@test.com",
      password: "test",
      password_confirmation: "test"
    })
    {:ok, conn: conn, user: user}
  end

  defp login(conn, user) do
    conn |> post("/sessions", %{username: user.username, password: user.password})
  end

  test "GET /polls", %{conn: conn, user: user} do
    {:ok, poll} = Votes.create_poll_with_options(%{title: "Poll 1", user_id: user.id}, ["Choice 1", "Choice 2", "Choice 3"])
 
    conn = get conn, "/polls"
    assert html_response(conn, 200) =~ poll.title
    Enum.each(poll.options, fn option ->
      assert html_response(conn, 200) =~ "#{option.title}"
      assert html_response(conn, 200) =~ "#{option.votes}"
    end)
  end

  test "GET /polls/new with a logged in user", %{conn: conn, user: user} do
    conn = login(conn, user) |> get("/polls/new")
    assert html_response(conn, 200) =~ "New Poll"
  end

  test "GET /polls/new without a logged in user", %{conn: conn} do
    conn = get(conn, "/polls/new")
    assert redirected_to(conn) == "/"
    assert get_flash(conn, :error) == "You must be logged in to do that!"
  end

  test "POST /polls (with valid data)", %{conn: conn, user: user} do
    conn = login(conn, user)
    |> post("/polls", %{"poll" => %{"title" => "Test Poll"}, "options" => "One, Two, Three"})
    assert redirected_to(conn) == "/polls"
  end

  test "POST /polls (with invalid data)", %{conn: conn, user: user} do
    conn = login(conn, user)
    |> post("/polls", %{"poll" => %{"title" => nil}, "options" => "One, Two, Three"})
    assert html_response(conn, 302)
    assert redirected_to(conn) == "/polls/new"
  end

  test "POST /polls (with valid data, without logged in user)", %{conn: conn} do
    conn = post(conn, "/polls", %{"poll" => %{"title" => "Test Poll"}, "options" => "One, Two, Three"})
    assert redirected_to(conn) == "/"
    assert get_flash(conn, :error) == "You must be logged in to do that!"
   end
 end