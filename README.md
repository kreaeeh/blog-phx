# Elixir phoenix live view fullstack application

there are 2 methods to run the application

via docker compose, make sure to have docker installed and run the following command

 `docker compose build`

then run the following command 

`docker compose up`

this will install and run all required services (mysql, blog-phx web app) and run the migrations && seeders

open this link in browser http://localhost:4000 once done.



The second method is the manual way

To start your Phoenix server:

  * cd `blog`
  * install mysql server from the link below
  * Change the `config/dev.exs` to follow your db credentials . Make sure you change host to `local` instead of `db`
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/
  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
