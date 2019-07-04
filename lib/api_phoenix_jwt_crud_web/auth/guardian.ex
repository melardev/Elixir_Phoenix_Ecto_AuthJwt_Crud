defmodule ApiPhoenixJwtCrudWeb.Auth.Guardian do
  use Guardian, otp_app: :api_phoenix_jwt_crud

  alias ApiPhoenixJwtCrud.Auth

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Auth.get_user!(id)
    {:ok,  resource}
  end

  def authenticate(username, password) do
    with {:ok, user} <- Auth.User.get_by_username(username) do
      case validate_password(password, user.hashed_password) do
        true ->
          create_token(user)
        false ->
          {:error, :unauthorized}
      end
    end
  end

  defp validate_password(password, hashed_password) do
    # https://github.com/riverrun/comeonin/blob/master/UPGRADE_v5.md
    Bcrypt.verify_pass(password, hashed_password)
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user, %{username: user.username})
    {:ok, user, token}
  end
end
