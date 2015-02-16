defmodule LambdaDays.Repo do
	use Ecto.Repo,
		otp_app: :lambda_days,
		adapter: Ecto.Adapters.Postgres

	def priv do
		app_dir(:lambda_days, "priv/repo")
	end
end
