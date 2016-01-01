defmodule Gemfire.Client do
  @moduledoc false
  
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, [])
  end

  def init(_opts) do
    {:ok, %{}}
  end

  def handle_call({:insert, region, key, value}, _from, state) do
      {:reply, execute(:post, "#{region}?key=#{key}", value), state}
    end

  def handle_call({:upsert, region, key, value}, _from, state) do
    {:reply, execute(:put, "#{region}/#{key}?op=PUT", value), state}
  end

  def handle_call({:delete, region, key}, _from, state) do
    {:reply, execute(:delete, "#{region}/#{key}"), state}
  end

  def handle_call({:getAllKeys, region}, _from, state) do
    {:reply, execute(:get, "#{region}/keys"), state}
  end

  def handle_call({:get, region, key}, _from, state) do
    {:reply, execute(:get, "#{region}/#{key}"), state}
  end

  def handle_call({:listQueries}, _from, state) do
    {:reply, execute(:get, "queries"), state}
  end

  def handle_call({:createQuery, id, q}, _from, state) do
     {:reply, execute(:post, "queries?id=#{id}&q=#{q}", ""), state}
  end

  def handle_call({:updateQuery, id, q}, _from, state) do
    {:reply, execute(:put, "queries/#{id}?q=#{q}", ""), state}
  end

  def handle_call({:executeQuery, id, args}, _from, state) do
    {:reply, execute(:post, "queries/#{id}", args), state}
  end

  def handle_call({:deleteQuery, id}, _from, state) do
    {:reply, execute(:delete, "queries/#{id}"), state}
  end

  def handle_call({:query, q}, _from, state) do
    {:reply, execute(:get, "queries/adhoc?q=#{q}"), state}
  end



  def baseurl() do
     "#{System.get_env("host")}:#{System.get_env("port")}/gemfire-api/v1/"
  end



  def execute(:get, url) do
    reply(HTTPoison.get("#{baseurl()}#{URI.encode(url)}"))
  end

  def execute(:delete, url) do
    reply(HTTPoison.delete("#{baseurl()}#{URI.encode(url)}"))
  end

  def execute(:put, url, value) do
    {:ok, json_value} = JSX.encode value
    reply(HTTPoison.put("#{baseurl()}#{URI.encode(url)}", json_value, [{"content-type", "application/json"}]))
  end

  def execute(:post, url, value) do
    {:ok, json_value} = JSX.encode value
    reply(HTTPoison.post("#{baseurl()}#{URI.encode(url)}", json_value, [{"content-type", "application/json"}]))
  end



  def reply({:ok, response}) do
    {:ok, value} = case response.body do
      "" -> {:ok, :success}
      other -> JSX.decode response.body
    end
    case response.status_code do
      200 -> {:ok, value}
      201 -> {:ok, value}
      400 -> {:error, :bad_request}
      404 -> {:error, :not_found}
      409 -> {:error, :mismatch}
      500 -> {:error, :system}
    end
  end

  def reply({:error, reason}) do
    {:error, reason}
  end

end