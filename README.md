# jQuest

[![](http://imgur.com/zwhZfsd.png)](http://www.jquestapp.com)

## Install in `development`

The following guide explain how to install jQuest for development purpose.

### 0. Install system dependencies

This may change according to your OS. On Ubuntu you must install those header packages to be able to compile ruby dependencies:

  sudo apt-get install ruby-dev libpq-dev libsqlite3-dev

### 1. Setup packages

Assuming you already installed [Ruby], [Bundler] and [Bower] on your computer.

    make install

### 2. Configure environment

You must specify a few environment variables. Those variables can be set using
a file `config/local-env.yml` (it will be loaded when the app will start).

Name | Description | Examples
--- | --- | ---
<var>DB_ADAPTER</var> | The database adapter to use | `postgresql`, `sqlite3`
<var>DATABASE_URL</var> | The database URI to use | `postgres://user:password@localhost:5432/jquest`, `db/development.sqlite3`
<var>SLACK_API_TOKEN</var> | User API token to connect to Slack you can get [from here](https://api.slack.com/web). | `xoxp-XXXXXXXXXXX-XXXXXXXXXXX-XXXXXXXXXXX-XXXXXXXXXXX`

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

## Install inside a Docker for `production`

![](http://imgur.com/lFvhAEH.png)

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

## Environment variables in `production`

As mentioned above, jQuest can be configured with environment variables:

Name | Description | Examples
--- | --- | ---
<var>DB_ADAPTER</var> | The database adapter to use. | `postgresql`, `sqlite3`
<var>DATABASE_URL</var> | The database URI to use. | `postgres://user:password@localhost:5432/jquest`, `db/development.sqlite3`
<var>SLACK_API_TOKEN</var> | User API token to connect to Slack you can get [from here](https://api.slack.com/web). | `xoxp-XXXXXXXXXXX-XXXXXXXXXXX-XXXXXXXXXXX-XXXXXXXXXXX`
<var>ASSET_HOST</var> | Hostname that distribute the assets. | `//asset.jquestapp.com`
<var>HOSTNAME</var> | Hostname of the app (needed by mailers). |  `http://www.jquestapp.com`
<var>S3_BUCKET</var> | Bucket name to upload files to. | `static.jquestapp.com`
<var>AWS_ACCESS_KEY_ID</var> | AWS access key id. |
<var>AWS_SECRET_ACCESS_KEY</var> | AWS secret key. |
<var>AWS_REGION</var> |  AWS region to distribute files. | `eu-west-1`
<var>RAILS_SERVE_STATIC_FILES</var> | Should Rails serve assets? | `1`
<var>RAILS_LOG_TO_STDOUT</var> | Should Rails print logs to stdout? | `1`
<var>MEMCACHIER_SERVERS</var> | If present, activates cache with Memcahier. List Memcahier servers. | `something.ec2.memcachier.com:11211`
<var>MEMCACHIER_USERNAME</var> | Memcachier username. |
<var>MEMCACHIER_PASSWORD</var> | Memcachier password. |
<var>NEW_RELIC_APP_NAME</var> | If present, activates RPM measure with New Relic. | `jquest`
<var>NEW_RELIC_LICENSE_KEY</var> | New Relic Licence key. |
<var>NEW_RELIC_LOG</var> | New Relic source. | `stdout`
<var>SENDGRID_USERNAME</var> | If present, uses SendGrid as mailer. | `contact@jplusplus.org`
<var>SENDGRID_PASSWORD</var> | SendGrid passowrd. |
<var>WEB_CONCURRENCY</var> | Number of concurrent process to start with Puma | `1`

## Setting up SSL on Heroku

Follow this [tutorial](https://medium.com/should-designers-code/how-to-set-up-ssl-with-lets-encrypt-on-heroku-for-free-266c185630db) to get SSL certificat from EFF. Enable SSL with Fatly using this [tutorial](https://docs.fastly.com/guides/securing-communications/setting-up-free-tls).


[Ruby]: https://www.ruby-lang.org/en/documentation/installation/
[Bower]: http://bower.io/#install-bower
[Bundler]: http://bundler.io
