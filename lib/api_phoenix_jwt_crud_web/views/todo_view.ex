defmodule ApiPhoenixJwtCrudWeb.TodoView do
  use ApiPhoenixJwtCrudWeb, :view
  alias ApiPhoenixJwtCrudWeb.TodoView

  def render("index.json", %{todos: todos}) do
    render_many(todos, TodoView, "todo.json")
  end

  def render("show.json", %{todo: todo}) do
    render_one(todo, TodoView, "todo.json")
  end

  def render("todo.json", %{todo: todo}) do
    %{id: todo.id,
      title: todo.title,
      description: todo.description,
      completed: todo.completed,
      created_at: NaiveDateTime.to_string(todo.created_at),
      updated_at: NaiveDateTime.to_string(todo.updated_at)
    }
  end
end
