defmodule KuboWeb.RoomLive.Index do
  use KuboWeb, :live_view

  alias Kubo.Chats
  alias Kubo.Chats.Room

  @impl true
  def mount(_params, _session, socket) do
    {:ok, 
      stream(socket, :rooms, Chats.list_rooms())
      |> assign(:test, "Test")
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Room")
    |> assign(:room, Chats.get_room!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Room")
    |> assign(:room, %Room{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rooms")
    |> assign(:room, nil)
  end

  @impl true
  def handle_info({KuboWeb.RoomLive.FormComponent, {:saved, room}}, socket) do
    {:noreply, stream_insert(socket, :rooms, room)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    room = Chats.get_room!(id)
    {:ok, _} = Chats.delete_room(room)

    {:noreply, stream_delete(socket, :rooms, room)}
  end
end
