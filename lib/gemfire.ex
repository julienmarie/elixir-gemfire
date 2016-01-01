defmodule Gemfire do
  @moduledoc false
  
  use Application

  def set_host(host,port) do
    System.put_env("host", host)
    System.put_env("port", port)
  end

  def upsert(region, key, value) do
    :poolboy.transaction(
      :gemclient,
      fn(worker) -> GenServer.call(worker, {:upsert, region, key, value} ) end
    )
  end

  def insert(region, key, value) do
      :poolboy.transaction(
        :gemclient,
        fn(worker) -> GenServer.call(worker, {:insert, region, key, value} ) end
      )
    end

  def getAllKeys(region) do
    :poolboy.transaction(
      :gemclient,
      fn(worker) -> GenServer.call(worker, {:getAllKeys, region} ) end
    )
  end

  def get(region, key) do
    :poolboy.transaction(
      :gemclient,
      fn(worker) -> GenServer.call(worker, {:get, region, key} ) end
    )
  end

  def delete(region, key) do
    :poolboy.transaction(
      :gemclient,
      fn(worker) -> GenServer.call(worker, {:delete, region, key} ) end
    )
  end

  def listQueries() do
    :poolboy.transaction(
      :gemclient,
      fn(worker) -> GenServer.call(worker, {:listQueries} ) end
    )
  end

  def createQuery(id, q) do
    :poolboy.transaction(
      :gemclient,
      fn(worker) -> GenServer.call(worker, {:createQuery, id, q} ) end
    )
  end

  def updateQuery(id, q) do
    :poolboy.transaction(
      :gemclient,
      fn(worker) -> GenServer.call(worker, {:updateQuery, id, q} ) end
    )
  end

  def executeQuery(id, args) do
    :poolboy.transaction(
      :gemclient,
      fn(worker) -> GenServer.call(worker, {:executeQuery, id, args} ) end
    )
  end

  def deleteQuery(id) do
    :poolboy.transaction(
      :gemclient,
      fn(worker) -> GenServer.call(worker, {:deleteQuery, id} ) end
    )
  end

  def query(q) do
    :poolboy.transaction(
      :gemclient,
      fn(worker) -> GenServer.call(worker, {:query, q} ) end
    )
  end



  def start(_type, _args) do
    Gemfire.set_host("http://localhost","7075")
    Gemfire.Supervisor.start_link()
  end
end