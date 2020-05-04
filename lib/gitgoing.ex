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


  def create_map do
     _map = %{}
  end

  def add_name(map) do
     Map.put(map, :first_name, String.trim(IO.gets("What's your first name? ")))
  end

  def get(map, key) do
     Map.get(map, key)
  end

end
