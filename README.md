manus is a webapp used by [International Hope Canada](https://www.internationalhope.ca/) for tracking inventory.

## Development

manus is a Ruby on Rails app. The installation for development is typical of Ruby on Rails apps, including

- Installing Ruby (typically through rbenv)
- Running `bundle`
- Running `rails db:migrate`
- Running `rails s` to start the server
- Accessing at http://localhost:8080

## Production build

To build and run the production image locally: `docker compose up --build`

To do a manual transfer:

```
export TAG=0.1
docker compose build
docker save -o images/manus-${TAG}.tar manus-web-production
```

This TAR is ~200MB. Transfer it to the server, as well as the `compose.yaml` file. Then on the server:

```
docker load -i manus-(TAG).tar
TAG=(build number) docker compose up
```

This can be turned off with:
```
TAG=(build number) docker compose down
```

## Backup

The database is stored in a volume called manus_db. The database file to back up is `production.sqlite3`.

To copy from a running container, run `docker ps` to get the container ID, then run:

```
docker cp (container ID):/rails/storage/production.sqlite3 ./manus-production.sqlite
```