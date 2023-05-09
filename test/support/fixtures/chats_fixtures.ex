defmodule Kubo.ChatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kubo.Chats` context.
  """

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Kubo.Chats.create_room()

    room
  end
end
