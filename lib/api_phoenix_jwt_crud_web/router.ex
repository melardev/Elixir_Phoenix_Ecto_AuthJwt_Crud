defmodule ApiPhoenixJwtCrudWeb.Router do
  use ApiPhoenixJwtCrudWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ApiPhoenixJwtCrudWeb.Auth.Pipeline
  end

  scope "/api", ApiPhoenixJwtCrudWeb do
    pipe_through([:api, :auth])
    get "/users/self", UserController, :self_info
    resources "/todos", TodoController, only: [:create, :update, :delete]
  end

  scope "/api", ApiPhoenixJwtCrudWeb do
    pipe_through :api
    resources "/todos", TodoController, except: [:new, :edit, :create, :update, :delete]

    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    post "/users", UserController, :register
    post "/auth/login", UserController, :login
  end




end
