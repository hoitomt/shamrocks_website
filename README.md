# Shamrocks Website
Website for the Eau Claire Shamrocks basketball club

## Development

### New Machine
- Install postgres `brew install postgresql`
  - version doesn't matter - this is to install the postgres libraries on the machine. The version will be set by Docker
- Install mimetypes: `brew install shared-mime-info`
- Install nvm: `brew install nvm`
- Setup .env
  - `cp .env.example .env`
  - Update the keys in .env
- Install bundler `gem install bundler`
- Install yarn `npm install --global yarn`

### Create the Postgres database container
```
docker-compose up
```

### Setup the Rails environment
1. Use rbenv or rvm
   1. Ruby version is defined by .ruby-version
   1. If necessary install correct version with `RUBY_CFLAGS="-w" rbenv install <version from .ruby-version>`
1. Use nvm for node version management
   1. Node is defined by .nvmrc
   1. Install Nodejs with `nvm install`.
1. Set the vendor folder in bundler `bundle config set --local path 'vendor'`
1. Install gems: `bundle install`
1. Setup Webpacker: `bundle exec rails webpacker:install`

### Run
- Start the webserver: `bundle exec rails s`
- Start the asset server: `./bin/webpack -w`
