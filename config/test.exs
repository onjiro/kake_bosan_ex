use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :kake_bosan_ex, KakeBosanEx.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :kake_bosan_ex, KakeBosanEx.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "kake_bosan_ex_test",
  size: 1 # Use a single connection for transactional tests
