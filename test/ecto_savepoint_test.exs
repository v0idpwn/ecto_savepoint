defmodule EctoSavepointTest do
  use ExUnit.Case
  doctest EctoSavepoint

  defmodule FakeRepo do
    use EctoSavepoint

    def get_dynamic_repo, do: __MODULE__
    def query(string), do: string
  end

  test "the functions call the proper queries" do
    assert "SAVEPOINT my_savepoint" == EctoSavepoint.savepoint(FakeRepo, "my_savepoint")
    assert "ROLLBACK TO SAVEPOINT my_savepoint" == EctoSavepoint.rollback_to_savepoint(FakeRepo, "my_savepoint")
  end

  test "injects the functions" do
    assert function_exported?(FakeRepo, :savepoint, 1)
    assert function_exported?(FakeRepo, :rollback_to_savepoint, 1)
  end
end
