# defmodule Main do
#     port = Mapit.udp_on(10110)
#     pid_map_manager = spawn(Mapit, :map_manager, [%{}, self()])
#     pid_parser = spawn(Mapit, :parser, [pid_map_manager])
#     pid_grabber = spawn(Mapit, :grabber, [port, pid_parser])
# end
