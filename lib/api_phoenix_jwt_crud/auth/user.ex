defmodule ApiPhoenixJwtCrud.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :hashed_password, :string

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_format(:email, ~r/^[A-Za-z0-0._-]+@[A-Za-z0-0.-]+\.[A-Za-z]{2,4}$/)
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> hash_password
  end

  def hash_password(changeset) do
    # https://github.com/riverrun/comeonin/blob/master/UPGRADE_v5.md
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :hashed_password, Bcrypt.hash_pwd_salt(password))
        _ -> changeset
    end
  end

  def get_by_username(username) do
    case ApiPhoenixJwtCrud.Repo.get_by(ApiPhoenixJwtCrud.Auth.User, username: username) do
      nil ->
        {:error, :not_found}
      user ->
        {:ok, user}
    end
  end
end
