# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :vocial,
  ecto_repos: [Vocial.Repo]

# Configures the endpoint
config :vocial, VocialWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ja021WAw9Dm92KVBoVUXsCb9egLwcEwgXj26HiP0xl16wCsnXw1kzmuX9oblQHcu",
  render_errors: [view: VocialWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Vocial.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :ueberauth, Ueberauth,
providers: [
  twitter: {Ueberauth.Strategy.Twitter, []},
  google: {Ueberauth.Strategy.Google, []}
]

config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET")

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CONSUMER_KEY"),
  client_secret: System.get_env("GOOGLE_CONSUMER_SECRET")
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
