defmodule HeliosWeb.RoomChannel do
  use HeliosWeb, :channel

  @impl true
  def join("room:lobby", payload, socket) do
    HeliosWeb.Endpoint.subscribe("room:lobby")
    :ok = Phoenix.PubSub.subscribe(Helios.PubSub, "room:lobby")
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    # HeliosWeb.Endpoint.broadcast_from(self(), "room:lobby", "shout", payload)
    IO.puts("[RoomChannel] shout end")
    {:noreply, socket}
  end


  def handle_out(e,p,socket) do
    push(socket, e, p)
    IO.puts("[RoomChannel]  handle out")
    IO.inspect(e)
    IO.inspect(p)
    {:noreply, socket}
  end
  def handle_info(data, socket) do
    IO.puts("[RoomChannel] info")
    IO.inspect(data,socket)
    socket= cond do
        data.event == "e" ->
          IO.puts("[RoomChannel] handle_info[m]")
          Phoenix.Channel.push(socket, "RobotBloc", data.payload)
          socket

        true ->
          socket
      end

    {:noreply, socket}
  end


  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
