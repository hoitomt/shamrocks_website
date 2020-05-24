# Shamrocks Website
Website for the Eau Claire Shamrocks basketball club

## Development

### Create the Postgres database container
```
docker-compose up
```

### Setup the Rails environment
1. Use rbenv or rvm
   1. Ruby version is defined by .ruby-version
   1. If necessary install correct version with `rbenv install <version from .ruby-version>`
1. Use nvm for node version management
   1. Node is defined by .nvmrc
   1. Install the correct version with `nvm install <version from .nvmrc>`
1. Install gems: `bundle install`
1. Use yarn, as directed by Rails
   1. Update Yarn `yarn install --check-files`
1. Setup Webpacker: `bundle exec rails  webpacker:install`

### Run
- Start the webserver: `bundle exec rails s`
- Start the asset server: `./bin/webpack-dev-server`
