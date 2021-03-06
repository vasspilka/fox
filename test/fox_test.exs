defmodule FoxTest do
  use ExUnit.Case

   # Run the test twice and inspect that the value should be different
  test "Fox.RandomExt.uniform" do
    k = Fox.RandomExt.uniform(99)
    IO.puts k
    assert k
  end

  test "Fox.UriExt.encode_query should encode complex queries" do
    query = [
      dog: "rover", 
      cats: ["mrmittens", "fluffmeister"], 
      mascots: %{ember: "hamster", go: "gopher"}
    ]
    actual = query |> Fox.UriExt.encode_query |> String.replace("%5B", "[") |> String.replace("%5D", "]")
    expected = "dog=rover&cats[]=mrmittens&cats[]=fluffmeister&mascots[ember]=hamster&mascots[go]=gopher"
    assert actual == expected
  end

  test "encode_query should work on maps also" do
    query = %{
      "cat" => "fluffy",
      "dogs" => ["rover", "spot"]
    }
    actual = query |> Fox.UriExt.encode_query |> String.replace("%5B", "[") |> String.replace("%5D", "]")
    expected = "cat=fluffy&dogs[]=rover&dogs[]=spot"
    assert actual == expected
  end

  test "it should handle empty things just fine" do
    q1 = %{}
    q2 = []
    assert Fox.UriExt.encode_query(q1) == ""
    assert Fox.UriExt.encode_query(q2) == ""
  end

  test "Fox.UriExt.fmt should work" do
    actual = "customers/:custmer_id/cards/:id/thing/:id" |> Fox.UriExt.fmt({"cus_666", "car_616", "444"})
    expected = "customers/cus_666/cards/car_616/thing/444"
    assert actual == expected
  end

  test "Fox.ParExt.|> should calculate things in parallel" do
    import Kernel, except: [{:|>, 2}]
    import Fox.ParExt, only: [{:|>, 2}]
    plus = fn x -> x + 1 end
    times = fn x -> x * 9 end
    actual = {1,2} |> {plus.(), times.()}
    expected = {2, 18}
    assert actual == expected
  end

  
end
