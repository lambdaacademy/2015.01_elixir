defmodule PhoenixCrud.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", PhoenixCrud do
    pipe_through :browser # Use the default browser stack

    get "/", WelcomeController, :index, as: :root # this gives us root_path
    get "/pages/:page", PageController, :show, as: :page
    resources "/users", UserController
    get "/signin", AuthController, :signin, as: :signin
    post "/authenticate", AuthController, :authenticate
    get "/logout", AuthController, :logout, as: :logout
    resources "/talks", TalkController
  end

  # Other scopes may use custom stacks.
  scope "/api", PhoenixCrud do
    pipe_through :api
    get "/user_exists", ApiController, :user_exists
    get "/check_password", ApiController, :check_password
  end
end
