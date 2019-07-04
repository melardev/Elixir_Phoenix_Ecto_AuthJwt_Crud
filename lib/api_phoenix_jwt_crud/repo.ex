defmodule ApiPhoenixJwtCrud.Repo do
  use Ecto.Repo,
    otp_app: :api_phoenix_jwt_crud,
    adapter: Ecto.Adapters.Postgres
end
