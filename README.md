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
2. Run the migrations `mix ecto.migrate LambdaDays.Repo`
3. Start Phoenix router with `mix phoenix.server`
4. Kill it with Ctrl-C Ctrl-C
5. You can also start Phoenix with interactive Elixir shell `iex -S mix phoenix.server`
6. Add first user to database:

        admin = %LambdaDays.User{admin: true, email: "admin@lambdadays.org", password: "admin", username: "admin"}
        LambdaDays.Repo.insert admin

7. Enjoy.

Now you can visit `localhost:4000` from your browser.

# Goals
- Learn basic elixir.
- Create admin and non-admin users.
- Provide authentication
- Provide API for MongooseIM auth
- Enable adding talks from Lambda Days
- Enable rating talks by users and external API
- Integrate with chat and streaming

# Using `Talk Api`

## Indexing all talks

To take all talks from the database just go to the page: `talk_api/index`. Eg.

```
curl http://localhost:4000/talk_api/index
```

Sample response:
```
{
  "talks":
    [
      {
        "id":1,
        "title":"sample_title",
        "description":"sample_description"
        "plus_votes":0,
        "zero_votes":0,
        "minus_votes":0,
      },
      {
        "id":2,
        "title":"sample_title_2",
        "description":"sample_description_2"
        "plus_votes":0,
        "zero_votes":0,
        "minus_votes":0,
      }
    ]
}
```

## Add rate for the talk

Prepare file request.txt with content:

```
{
  "id":1,
  "plus_votes":1,
  "zero_votes":2,
  "minus_votes":4
}
```
and try to update talk using `talk_api/update` REST api:
```
curl -X POST -d @request.txt http://localhost:4000/talk_api/update --header "Content-Type:application/json"
```

The result should be similar to the following:
```
{
  "talk":
    {
      "id":1,
      "title":"sample_title",
      "description":"sample_description"
      "plus_votes":1,
      "zero_votes":2,
      "minus_votes":4,
    }
}
```
