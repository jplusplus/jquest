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
SLACK_API_TOKEN | User API token to connect to Slack you can get [from here](https://api.slack.com/web). | `xoxp-XXXXXXXXXXX-XXXXXXXXXXX-XXXXXXXXXXX-XXXXXXXXXXX`

For instance, to use the app with SQLite:

```yml
DB_ADAPTER: sqlite3
DATABASE_URL: db/development.sqlite
SLACK_API_TOKEN: xoxp-whatever-you-got-from-slack
```

### 3. Setup and populate database

    rails db:setup

If you use PostgreSQL, an alternative way to setup the database is to get a copy from the production. **This is a destructive action** since it remove your local database to fill it with real-life data. Use the following command:

    make pg-pull

### 4. Run

The app autoreloads when changing ruby files, or assets.

    make run

## Boot inside a Docker for production

### Build the container

To ease the deployment of jQuest, we provide a Dockerfile to build the app
and get ready for production with a single command line:

    docker build --build-arg ASSET_HOST=//assets.jquestapp.com -t jquest .

**Note:** Here we build the assets using the default host but it must be your own server or a CDN.

### Run the instance

Use environments variables within your Docker host to configure the app. Any existing `config/local-env.yml` file will be ignored.

Assuming you named your container `jquest` as above, simply run:

    docker run -p 3333:3000 -it jquest bin/web

Your app is now listening on [localhost:3333](http://localhost:3333)




[Ruby]: https://www.ruby-lang.org/en/documentation/installation/
[Bower]: http://bower.io/#install-bower
[Bundler]: http://bundler.io
