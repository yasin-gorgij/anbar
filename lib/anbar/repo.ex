defmodule Anbar.Repo do
  use Ecto.Repo,
    otp_app: :anbar,
    adapter: Ecto.Adapters.SQLite3
end
