defmodule ElixirLS.Debugger.Mixfile do
  use Mix.Project

  @version __DIR__
           |> Path.join("../../VERSION")
           |> File.read!()
           |> String.trim()

  def project do
    [
      app: :elixir_ls_debugger,
      version: @version,
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: ">= 1.12.0",
      build_embedded: false,
      start_permanent: true,
      build_per_environment: false,
      # if we consolidate here debugged code will not work correctly
      # and debugged protocol implementation will not be available
      consolidate_protocols: false,
      deps: deps(),
      xref: [exclude: [:int, :dbg_iserver]]
    ]
  end

  def application do
    [mod: {ElixirLS.Debugger, []}, extra_applications: [:mix]]
  end

  defp deps do
    [
      {:elixir_sense,
       github: "elixir-lsp/elixir_sense", ref: "71efd1e2efbac43e6c98c525cc879ddd747ac62e"},
      {:elixir_ls_utils, in_umbrella: true},
      {:jason_v, github: "elixir-lsp/jason", ref: "c81537e2a5e1acacb915cf339fe400357e3c2aaa"},
      {:dialyxir_vendored,
       github: "elixir-lsp/dialyxir",
       ref: "896fa45817c6a1be8ec408577c88ab52c27f6851",
       runtime: false}
    ]
  end
end
