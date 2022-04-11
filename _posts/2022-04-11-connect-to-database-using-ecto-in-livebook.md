---
layout: post
title:  connect to database using ecto in livebook 
date:   2022-04-11 02:00 
categories: tech
---
```markdown

# connect to database using ecto in livebook

## Section


```elixir
Mix.install([
  {:ecto_sql, "~> 3.0"},
  {:postgrex, ">= 0.0.0"}
])
```

```elixir
defmodule Hello.Repo do
  use Ecto.Repo,
    otp_app: :hello,
    adapter: Ecto.Adapters.Postgres
end
```

```elixir
defmodule Hello.Note.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field(:body, :string)
    field(:desc, :string)
    field(:tags, {:array, :string})
    field(:title, :string)

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :desc, :body, :tags])
    |> validate_required([:title, :desc, :body, :tags])
  end
end
```

```elixir
# TODO: How to connect to the database

# { :ok, pid } = Postgrex.start_link(hostname: "localhost", username: "admin", password: "", database: "my_db")#
# result = Postgrex.query!(pid, "select * from some_table limit 1", [])
```

```elixir
Hello.Repo.start_link(url: "postgres://your_pg_uri", ssl: false)
```

```elixir
Hello.Repo.aggregate(Hello.Note.Article, :count)
```


```

```
