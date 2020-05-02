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
  def hello do
    :world
  end

  ## Testing adding values to a map
  ## Don't like how I have to declare an empty map, should this go here?

  def create_map do
     map = %{}
  end

  def add_name(map) do
     Map.put(map, :first_name, String.trim(IO.gets("What's your first name? ")))
  end

  def get(map, key) do
     Map.get(map, key)
  end

#  customers = %{}
#  Gitgoing.get_info()

#  def get_info do
#    fname = IO.gets("What's your first name? ")
#    Map.put(customers, :first_name, fname)
#    inspect customers
#  end
  
end
