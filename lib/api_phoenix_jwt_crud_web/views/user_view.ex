defmodule ApiPhoenixJwtCrudWeb.UserView do
  use ApiPhoenixJwtCrudWeb, :view
  alias ApiPhoenixJwtCrudWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user, jwt: jwt}) do
    %{
      username: user.username, email: user.email, jwt: jwt
    }
  end

  def render("user.json", %{user: user, jwt: jwt}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      token: jwt}
  end
end
