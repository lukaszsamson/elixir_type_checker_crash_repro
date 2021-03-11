defmodule TypeCheckerCrash.Some do
  alias TypeCheckerCrash.Model.SomeStruct

  def process(_state, candidates) do
    with {:ok, results} <- TypeCheckerCrash.hello do
      Enum.zip(candidates, results)
        |> Map.new(fn
          {tx, {:ok, nil}} -> {tx, :failed}
          {tx, {:ok, %SomeStruct{abc: nil}}} -> {tx, :completed}
          {tx, {:ok, %SomeStruct{}}} -> {tx, :pending}
        end)
    else
      _error ->
        nil
    end
  end
end
