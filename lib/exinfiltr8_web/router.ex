defmodule Exinfiltr8Web.Router do
  use Exinfiltr8Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug MilitermWeb.UserAuth.Pipeline
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :ensure_admin do
  end

  scope "/", MilitermWeb do
    pipe_through [:browser, :auth]

    get "/auth/:provider", AuthController, :request
    get "/auth/:provider/callback", AuthController, :callback
    post "/auth/:provider/callback", AuthController, :callback
  end

  scope "/", MilitermWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    resources "/game", CharacterController, only: [:index, :show, :new, :create]
    get "/game/:character/play", CharacterController, :play

    get "/game/auth/:session_id", SessionController, :auth_session
    post "/auth/logout", AuthController, :delete
  end

  scope "/", Exinfiltr8Web do
    pipe_through [:browser, :auth]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Exinfiltr8Web do
  #   pipe_through :api
  # end
end
