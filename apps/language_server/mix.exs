defmodule ElixirLS.LanguageServer.Mixfile do
  use Mix.Project

  @version __DIR__
           |> Path.join("../../VERSION")
           |> File.read!()
           |> String.trim()

  def project do
    [
      app: :language_server,
      version: @version,
      elixir: ">= 1.12.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: false,
      start_permanent: true,
      build_per_environment: false,
      consolidate_protocols: Mix.env() != :test,
      deps: deps()
    ]
  end

  def application do
    [mod: {ElixirLS.LanguageServer, []}, extra_applications: [:mix, :logger]]
  end

  defp deps do
    [
      {:elixir_ls_utils, in_umbrella: true},
      {:elixir_sense,
       github: "elixir-lsp/elixir_sense", ref: "71efd1e2efbac43e6c98c525cc879ddd747ac62e"},
      {:erl2ex, github: "dazuma/erl2ex"},
      {:sourceror, "0.11.2"},
      {:dialyxir_vendored, github: "elixir-lsp/dialyxir", ref: "896fa45817c6a1be8ec408577c88ab52c27f6851", runtime: false},
      {:jason_v, github: "elixir-lsp/jason", ref: "c81537e2a5e1acacb915cf339fe400357e3c2aaa"},
      {:stream_data, "~> 0.5", only: [:dev, :test], runtime: false},
      {:path_glob_vendored, github: "elixir-lsp/path_glob", branch: "vendored"},
      {:patch, "~> 0.12.0", only: [:dev, :test], runtime: false},
      {:benchee, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      test: "test --no-start"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
