defmodule LambdaDays.Router do
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

  pipeline :talk_api do
    plug :accepts, ~w(json)
  end

  scope "/", LambdaDays do
    pipe_through :browser # Use the default browser stack

    get "/", WelcomeController, :index, as: :root # this gives us root_path
    get "/room/:room", RoomController, :index, as: :page
    get "/pages/:page", PageController, :show, as: :page
    resources "/users", UserController
    get "/signin", AuthController, :signin, as: :signin
    post "/authenticate", AuthController, :authenticate
    get "/logout", AuthController, :logout, as: :logout
    resources "/talks", TalkController
  end

  # Other scopes may use custom stacks.
  scope "/api", LambdaDays do
    pipe_through :api
    get "/user_exists", MongooseApiController, :user_exists
    get "/check_password", MongooseApiController, :check_password
  end

  scope "/talk_api", LambdaDays do
    pipe_through :talk_api
    get "/index", TalkApiController, :index
    post "/update", TalkApiController, :update
  end
end
