# Hostnfly-challenge

- Generate rails api
- Script to fill the database in backend/backend_test.rb
- Service that generate missions in services/generate_missions_service.rb
- Full CRUD for listings, bookings and reservations
- index endpoint for missions

## Concept

Fill database Listing, Booking and Reservation with a json file input. Call a service that handle some logics to fill Mission database. Outpout the missions created in a json file in backend/data/output.json

## Configuration

- clone the repo
- bundle install
- rails db:create db:migrate

## Run the program

```sh
ruby backend/backend_test.rb
```



