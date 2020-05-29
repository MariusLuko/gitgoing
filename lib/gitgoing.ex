defmodule Gitgoing do

  require Logger

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
#  {:ok, {ip, port, msg}} = :gen_udp.recv(socket,0)

  def sampledata(port) do
    IO.inspect(self())
    socket = Gitgoing.open_udp(port)
    if :failed == socket do
      IO.puts ("Please try again")
      Logger.info("THE PROCESS HAS FAILED")
    else
      IO.puts ("The socket is currently set to: #{inspect socket}")
      IO.puts("")
      socket
        |> Gitgoing.grab_packet
      :gen_udp.close(socket)
      IO.puts ("Socket #{inspect socket} has been closed successfully.")
    end
  end


  def open_udp(port) do
      case :gen_udp.open(port, [:binary, {:active, false}]) do
        {:ok, socket} -> IO.puts("Socket #{inspect socket} has been opened.")
          socket
        {:error, :eaddrinuse} -> IO.puts("This port is already in use")
          Logger.error("Error Logger test")
          :failed
        {:error, :eacces} -> IO.puts("This port is not allowed")
          :failed
      end
  end

  def grab_packet(port) do
      data = :gen_udp.recv(port,0)
      parse(data)
  end

  defp parse(packet) do
     case packet do
      #   {:ok, {_ip, _port, msg}} -> IO.inspect(msg)
        {:ok, {_ip, _port, msg}} -> IO.puts("Sample data: #{msg}")
        _ -> IO.puts("unexpected packet format")
     end
  end
end
