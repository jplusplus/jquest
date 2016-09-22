# jQuest

## Install in development

The following guide explain how to install jQuest for development purpose.

### 1. Setup packages

Assuming you already installed [Ruby], [Bundler] and [Bower] on your computer.

    make install

### 2. Configure environment

You must specify a few environment variables. Those variables can be set using
a file `config/local-env.yml` (it will be loaded when the app will start).

Name | Description | Examples
--- | --- | ---
DB_ADAPTER | The database adapter to use | `postgresql`, `sqlite3`
DATABASE_URL | The database URI to use | `postgres://user:password@localhost:5432/jquest`, `db/development.sqlite3`
SLACK_API_TOKEN | User API token to connect to Slack | `xoxp-XXXXXXXXXXX-XXXXXXXXXXX-XXXXXXXXXXX-XXXXXXXXXXX`

For instance, to use the app with SQLite:

```yml
DB_ADAPTER: sqlite3
DATABASE_URL: db/development.sqlite
SLACK_API_TOKEN: xoxp-whatever-you-got-from-slack
```

### 3. Setup and populate database

    rails db:setup

### 4. Run

The app autoreloads when changing ruby files, or assets.

    make run


[Ruby]: https://www.ruby-lang.org/en/documentation/installation/
[Bower]: http://bower.io/#install-bower
[Bundler]: http://bundler.io
