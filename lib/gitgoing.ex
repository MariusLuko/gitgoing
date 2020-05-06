defmodule Gitgoing do
  @moduledoc """
  Documentation for `Gitgoing`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Gitgoing.hello()
      :world

  """



#  {:ok, socket} = :gen_udp.open(10110, [:binary, {:active, false}])
#  :gen_udp.recv(socket,0)
# {:ok, {ip, port, msg}} = :gen_udp.recv(socket,0)

#  How can you get around needing to run "socket = Gitgoing.open_udp(10110)"?
#  Have this be called automatically by other code...

  def open_udp(port) do
      case :gen_udp.open(port, [:binary, {:active, false}]) do
         {:ok, socket} -> IO.puts("Socket #{inspect socket} has been opened.")
                          socket
      end
  end

  def grab_packet(port) do
     data = :gen_udp.recv(port,0)
     IO.inspect(data)
     parse(data)
  end

  defp parse(packet) do
     case packet do
        {:ok, {_ip, _port, msg}} -> IO.inspect(msg)
        _ -> IO.puts("unexpected packet format")
     end
  end

  #  socket = Gitgoing.open_udp(10110)
  #  Gitgoing.grab_packet(socket)

end
