# Gemfire

Naive quick and dirty REST client for Pivotal Gemfire / Apache Geode

## Usage

          Gemfire.set_host("http://localhost","7070")
          Gemfire.insert("myRegion","myKey", %{"hello" => "world"})
          Gemfire.get("myRegion", "myKey")
          Gemfire.upsert("myRegion","myKey", %{"hello" => "Beautiful world"})
          Gemfire.get("myRegion", "myKey")
          Gemfire.getAllKeys("myRegion")
          Gemfire.query("SELECT * FROM /myRegion r WHERE r.hello = 'Beautiful world'")
          Gemfire.createQuery("myQuery","SELECT * FROM /myRegion r WHERE r.hello = $1")
          Gemfire.listQueries()
          Gemfire.executeQuery("myQuery",[%{"@type"=>"string","@value"=>"Beautiful world"}])
          Gemfire.updateQuery("myQuery","SELECT * FROM /myRegion r WHERE r.hello.startsWith($1)")
          Gemfire.executeQuery("myQuery",[%{"@type"=>"string","@value"=>"Beautiful"}])
          Gemfire.deleteQuery("myQuery")
          Gemfire.delete("myRegion","myKey")
          

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add gemfire to your list of dependencies in `mix.exs`:

        def deps do
          [{:gemfire, "~> 0.0.1"}]
        end

  2. Ensure gemfire is started before your application:

        def application do
          [applications: [:gemfire]]
        end
