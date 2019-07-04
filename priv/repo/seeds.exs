# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ApiPhoenixJwtCrud.Repo.insert!(%ApiPhoenixJwtCrud.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


import Ecto.Query

# todosInDb = Repo.one(from p in "todos", select: count(p.id))
todosInDb = ApiPhoenixJwtCrud.Repo.aggregate(from(t in "todos"), :count, :id)
# Db Specific
# todosInDb = Repo.one(from p in "todos", select: fragment("count(*)"))

itemsToSeed = 13 - todosInDb

if itemsToSeed > 0 do
  IO.puts "Seeding #{itemsToSeed} items"
  Enum.each(0..itemsToSeed, fn(x) ->
    title = Faker.Lorem.word()
    description = FakerElixir.Lorem.sentences(2..5)
    # description = Enum.join(Faker.Lorem.sentences(2), ". ")
    completed = FakerElixir.Boolean.boolean(0.5)
    # created_at = DateTime.to_naive(Faker.DateTime.backward(4))
    created_at = DateTime.to_naive(DateTime.from_iso8601(FakerElixir.Date.backward(0..365)) |> elem(1))
    updated_at = DateTime.to_naive(DateTime.from_iso8601(FakerElixir.Date.backward(0..365)) |> elem(1))

    IO.puts description
    ApiPhoenixJwtCrud.Repo.insert! %ApiPhoenixJwtCrud.Todos.Todo{title: title,
      description: description,
      completed: completed,
      created_at: created_at,
      updated_at: updated_at}
  end)
end
