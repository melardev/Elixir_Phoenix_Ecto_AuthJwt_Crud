defmodule ApiPhoenixJwtCrudWeb.UserController do
  use ApiPhoenixJwtCrudWeb, :controller

  require IEx

  alias ApiPhoenixJwtCrud.Auth
  alias ApiPhoenixJwtCrud.Auth.User
  alias ApiPhoenixJwtCrudWeb.Auth.Guardian

  action_fallback ApiPhoenixJwtCrudWeb.FallbackController

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end


  def register(conn, user_params) do
    IEx.pry()
    with {:ok, %User{} = user} <- Auth.create_user(user_params),
    {:ok, jwt, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, jwt: jwt})
    end
  end

  def login(conn, %{"username" => username, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(username, password) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, jwt: token})
    end
  end

  def self_info(conn, _) do
    current_user = Guardian.Plug.current_resource(conn)
    claims = Guardian.Plug.current_claims(conn)
    conn
      |> put_status(200)
      |> json(%{success: true, username: current_user.username, claims: claims})
  end
end
