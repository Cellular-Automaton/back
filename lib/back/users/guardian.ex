defmodule Back.Users.Guardian do
  use Guardian, otp_app: :back

  alias Back.Users

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.user_id)}
  end

  def resource_from_claims(%{"sub" => user_id}) do
    user = Users.get_user!(user_id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
