defmodule EctoSavepoint.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_savepoint,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Savepoint wrapper for Ecto with Postgrex/Myxql",
      package: [
        name: "ecto_savepoint",
        licenses: ["Apache-2.0"],
        links: %{"GitHub" => "https://github.com/v0idpwn/ecto_savepoint"}
      ],
      name: "EctoSavepoint",
      source_url: "https://github.com/v0idpwn/ecto_savepoint",
      homepage_url: "https://github.com/v0idpwn/ecto_savepoint"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.25", only: :docs}
    ]
  end
end
