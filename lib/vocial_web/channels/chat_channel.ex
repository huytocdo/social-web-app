defmodule VocialWeb.ChatChannel do
  use VocialWeb, :channel

  alias Vocial.Votes

  def handle_in("new_message", %{"author" => author, "message" => message}, socket) do
    with {:ok, _message} <- Votes.create_message(%{author: author, message: message}) do
      broadcast socket, "new_message", %{author: author, message: message}
      {:reply, {:ok, %{author: author, message: message}}, socket}
    else
      _ -> {:reply, {:error, %{message: "Failed to send chat message"}}, socket}
    end
  end

  def join("chat:lobby", _payload, socket) do
    {:ok, socket}
  end
end