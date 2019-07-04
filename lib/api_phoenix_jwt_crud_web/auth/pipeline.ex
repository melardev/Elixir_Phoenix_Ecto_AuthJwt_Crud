defmodule ApiPhoenixJwtCrudWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :api_phoenix_jwt_crud,
    module: ApiPhoenixJwtCrudWeb.Auth.Guardian,
    error_handler: ApiPhoenixJwtCrudWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
