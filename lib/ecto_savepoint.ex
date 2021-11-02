defmodule EctoSavepoint do
  @moduledoc """
  Simple Ecto extension to use savepoints. Works with both postgrex and myxql.

  **Disclaimer:** savepoints are not officially supported by Ecto for a reason. 
  If you run into unexpected behaviour, please report so these cases can be documented here.

  Add this line in your Repo:
      use EctoSavepoint

  And you can now do:
      MyRepo.transaction(fn ->
        MyRepo.insert(...)

        MyRepo.savepoint("my_savepoint")

        MyRepo.insert(...)

        MyRepo.rollback_to_savepoint("my_savepoint")

        MyRepo.insert(...)
      end)

  This way, the insertions between savepoint and rollback are rolled back.

  If you don't want to `use`, you can do the calls directly, as in: 
      EctoSavepoint.savepoint(MyRepo, "my_savepoint")
  """

  @doc """
  Creates a savepoint

  Should be called within a transaction
  """
  @spec savepoint(repo :: module, name :: binary | atom) :: term
  def savepoint(repo, name) do
    repo.query("SAVEPOINT #{name}")
  end

  @doc """
  Creates a savepoint

  Should be called within the same transaction that created the savepoint
  """
  @spec rollback_to_savepoint(repo :: module, name :: binary | atom) :: term
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
