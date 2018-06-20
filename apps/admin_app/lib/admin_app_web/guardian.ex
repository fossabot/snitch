defmodule AdminAppWeb.Guardian do
  use Guardian, otp_app: :admin_app

  def subject_for_token(resource, claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    user_id = claims["sub"]
  end
end
