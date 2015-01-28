# 2015.01_elixir  [![Build Status](https://api.travis-ci.org/lambdaacademy/2015.01_elixir.svg)](https://travis-ci.org/lambdaacademy/2015.01_elixir)

This is application, that will help during Lambda Days 2015 held in Cracow.

It uses Elixir, Postgres and the [Phoenix Framework](https://github.com/phoenixframework/phoenix).

[Skeleton is based on this blog post](http://gogogarrett.sexy/programming-in-elixir-with-the-phoenix-framework-building-a-basic-CRUD-app/)

[Template updated to newest Elixir and Phoenix by rambocoder](https://github.com/rambocoder/phoenix_crud/)

# Installation

To start your new Phoenix application you have to:

0. Copy and edit example dev config:

    cp config/dev.example.exs config/dev.exs

1. Install dependencies with `mix deps.get`
2a. Start Phoenix router with `mix phoenix.server`
2b. You can also start Phoenix with interactive Elixir shell `iex -S mix phoenix.server`
3. Configure Database Settings in `config/config.exs` to use your local postgres enviorment.
4. Run the migrations `mix ecto.migrate PhoenixCrud.Repo`
5. Enjoy.

Now you can visit `localhost:4000` from your browser.

# Goals
- Learn basic elixir.
- Create admin and non-admin users.
- Provide authentication
- Provide API for MongooseIM auth
- Enable adding talks from Lambda Days
- Enable rating talks by users and external API
- Integrate with chat and streaming
