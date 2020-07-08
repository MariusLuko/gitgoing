defmodule Mapit do

  # Start a process that pulls incoming UDP packets and sends them to a parser
  # Parser needs to identify whether the packet came from a particular address
  # Start a process that maintains a map that holds the latest received data
  # Have ability to check on map key-value pair at any time

  ################################################################

  ### COMMANDS TO GET THINGS GOING ###

  # port = Mapit.udp_on(55555)
  # pid_map_manager = spawn(Mapit, :map_manager, [%{}, self()])
  # pid_parser = spawn(Mapit, :parser, [pid_map_manager])
  # pid_chopper = spawn(Mapit, :chopper, [port, pid_parser])

  # send(pid_map_manager, {:wholemap})
  # receive do msg -> IO.inspect(msg) end

  #################################################################



  # The map_manager maintains a dynamic map that is constantly storing
  # a unique value for each type of NMEA 0183 identifier. The map can
  # be called and modified using the commands below.

  def map_manager(map, parentpid) do
    receive do
      {:wholemap}        -> send(parentpid, map)
                            map_manager(map, parentpid)
      {:put, key, value} -> map = Map.put(map, key, value)
                            map_manager(map, parentpid)
      {:get, key}        -> send(parentpid, Map.get(map, key))
                            map_manager(map, parentpid)
    end
  end

  # udp_on tries to open a socket for a port and returns said socket

  def udp_on(port) do
    case :gen_udp.open(port, [:binary, {:active, false}]) do
      {:error, :eaddrinuse} -> IO.puts("This port is already in use.")
      {:error, :eacces} -> IO.puts("Permission was denied. Pick a different port.")
      {:ok, socket} -> IO.puts("Socket #{inspect socket} has been opened")
      socket
    end
  end


  # The chopper receives a UDP packet and, splits it by the $ symbol,
  # and sends everything to the parser.

  def chopper(port, routing_pid) do
    {:ok, {_ip, _port, msg}} = :gen_udp.recv(port,0)
    list = String.split(msg,"$")
    Enum.each(list, fn x -> send(routing_pid, x) end)
    chopper(port, routing_pid)
  end

  # The parser strips out and atomizes the NMEA 0183 identifier,
  # and sends the atom + sentence to the map manager

  def parser(map_manager_pid) do
    receive do
      sentence -> [head|tail] = String.split(String.trim(sentence),",")
                  key = String.to_atom(head)
                  send(map_manager_pid,{:put, key, tail})
                  parser(map_manager_pid)
    end
  end

  def udp_flood(port) do
    IO.inspect(:gen_udp.recv(port,0))
    udp_flood(port)
  end

end


  ### This loop mechanism works, but doesn't align properly and is unreadable
  # def loop(map_manager_pid) do
  #   send(map_manager_pid, {:wholemap})
  #   receive do
  #     map -> IO.inspect(map)
  #   end
  #   loop(map_manager_pid)
  # end
