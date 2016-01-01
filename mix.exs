defmodule Gemfire.Mixfile do
  use Mix.Project

  def project do
    [app: :gemfire,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
          applications: [
            :httpoison,
            :exjsx,
            :poolboy
          ]
        ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
       {:exjsx, "~> 3.0"},
       {:httpoison, "~> 0.6.0"},
       {:poolboy, "~> 1.5"}
    ]
  end

  @description """
      Naive quick and dirty REST client for Pivotal Gemfire / Apache Geode
  """

  defp package do
    [
     maintainers: ["Julien Marie"],
     licenses: ["MIT"],
     links: %{"Github" => "https://github.com/julienmarie/elixir-gemfire"}
     ]
  end
end
