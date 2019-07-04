# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api_phoenix_jwt_crud,
  ecto_repos: [ApiPhoenixJwtCrud.Repo]

# Configures the endpoint
config :api_phoenix_jwt_crud, ApiPhoenixJwtCrudWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "P6GYQXiIHfrqNmHGLsrddngYnOAtn4qtT3V/04m/iAha47L1RQIWr6OWIMKzk05B",
  render_errors: [view: ApiPhoenixJwtCrudWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ApiPhoenixJwtCrud.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# You could also use a secret generated with
# mix guardian.gen.secret
# McLD3O400yW1oji3IzTjxfW8zj4Eg5bSGQE6HXypY8d5sRsxFYYwqvHj9CbuXMWn
config :api_phoenix_jwt_crud, ApiPhoenixJwtCrudWeb.Auth.Guardian,
  issuer: "api_jwt_crud_app",
  secret_key: "JWT_SUPER_SECRET"
