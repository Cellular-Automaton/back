# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :back,
  ecto_repos: [Back.Repo],
  generators: [timestamp_type: :utc_datetime]

config :back, Back.Users.Guardian,
  issuer: "back",
  # NOTE: only for dev
  secret_key: "k/l7rLScT0JpArQ93NvJ+JYf86/YglzDd194xlSk1UQLspZy86kk5mqfAqK05/D0",
  serializer: Back.Token,
  token_salt: "your_salt"

# Configures the endpoint
config :back, BackWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: BackWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Back.PubSub,
  live_view: [signing_salt: "WA3lVmhM"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :back, Back.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
