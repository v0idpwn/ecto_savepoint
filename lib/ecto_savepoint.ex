defmodule EctoSavepoint do
  @moduledoc """
  Simple Ecto extension to use savepoints. Works with both postgrex and myxql.

  Add this line in your Repo:
      use EctoSavepoint

  And you can call:
      MyRepo.transaction(fn ->
        Repo.insert(...)

        Repo.savepoint("my_savepoint")

        Repo.insert(...)

        Repo.rollback_to_savepoint("my_savepoint")

        Repo.insert(...)
      end)
  """

  def savepoint(repo, name) do
    repo.query("SAVEPOINT #{name}")
  end

  def rollback_to_savepoint(repo, name) do
    repo.query("ROLLBACK TO SAVEPOINT #{name}")
  end

  defmacro __using__(_opts) do
    quote do
      def savepoint(name), do: EctoSavepoint.savepoint(get_dynamic_repo(), name)
      def rollback_to_savepoint(name), do: EctoSavepoint.rollback_to_savepoint(get_dynamic_repo(), name)
    end
  end
end
