manus is a webapp used by [International Hope Canada](https://www.internationalhope.ca/) for tracking inventory.

## Development

manus is a Ruby on Rails app. The installation for development is typical of Ruby on Rails apps, including

- Installing Ruby (typically through rbenv)
- Running `bundle`
- Running `rails db:migrate`
- Running `rails s` to start the server
- Accessing at http://localhost:8080

## Production build

To build and run: `RAILS_MASTER_KEY=(values from config/master.key) docker compose up --build`

To build only: `RAILS_MASTER_KEY=(values from config/master.key) docker compose build`

To do a manual transfer, create a TAR with `docker save -o manus.tar manus`. This can be loaded with `docker load -i manus.tar`. This file is ~200MB.

## Backup

The database is stored in a volume called manus_db. The database file to back up is `production.sqlite`.