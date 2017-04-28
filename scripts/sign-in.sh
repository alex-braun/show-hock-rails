#!/bin/bash

API="http://localhost:4741"
URL_PATH="/sign-in"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'",
      "password_confirmation": "'"${PASSWORD}"'"
    }
  }'

echo

# API="http://localhost:4741"
# URL_PATH="/sign-in"
# curl "${API}${URL_PATH}" \
#   --include \
#   --request POST \
#   --header "Content-Type: application/json" \
#   --data '{
#     "credentials": {
#       "email": "braunacb@gmail.com",
#       "password": "7777acb3",
#       "password_confirmation": "7777acb3"
#     }
#   }'
#
#   BAhJIiViMTE2YjZmMWYxYjc4NGVmYmYwMzZjYmViYjgwZTYyOAY6BkVG--41184e5b96ca3ae49cf3e11b48ecf58a1ca44013
API="http://localhost:4741"
URL_PATH="/sign-in"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "braunacb@gmail.com",
      "password": "7777acb3",
      "password_confirmation": "7777acb3"
    }
  }'


curl --include --request POST http://localhost:4741/sign-in \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "an@example.email",
      "password": "an example password"
    }
  }'
BAhJIiUwY2I1ZDBhNjg1YzVjOGM0NDYxNjUxMTMxYmIxODMzMgY6BkVG--60137d05d2c5767b5b1a4e2572db0db57e736b91

curl --include --request POST http://localhost:4741/sign-in \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "an@example2.email",
      "password": "an example2 password"
    }
  }'
BAhJIiUwMWU3MDBiMmJkNmVjZGY0NDIyMGU0ZmViODk2ZTgwMQY6BkVG--3c1fce52a13914463d8ac4dc2c5dcb608341eb9d

curl --include --request POST http://localhost:4741/sign-in \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "an@example3.email",
      "password": "an example3 password"
    }
  }'
BAhJIiU5NmFhYzhmYmIyZGJkZjE5MGM0NWY0N2Q1NDQ0MDQ0NgY6BkVG--5c11e6ab002d3d4fb3ff32c47ab29b1ef812d13a

curl --include --request POST http://localhost:4741/sign-in \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "an@example4.email",
      "password": "an example4 password"
    }
  }'
BAhJIiVlMzMyNDNiODIyMmNhMzQ0OTVkNmVkMWRiYjkzZDBjMAY6BkVG--0fc84f9b4d5b9a2ffa2680cb1b96ea5f64fb7cb0

curl --include --request POST http://localhost:4741/shows \
  --header "Authorization: Token token=BAhJIiU5NmFhYzhmYmIyZGJkZjE5MGM0NWY0N2Q1NDQ0MDQ0NgY6BkVG--5c11e6ab002d3d4fb3ff32c47ab29b1ef812d13a" \
  --header "Content-Type: application/json" \
  --data '{
    "show": {
      "start": "2017-04-29",
      "end": null,
      "city": "Miami",
      "state": "FL",
      "country": "US",
      "event_name": "PooPoo",
      "event_id": "225",
      "venue_name": "The Shit Tavern",
      "venue_id": "35355",
      "region_name": "Miami",
      "region_id": "41234"
    }
  }'

"BAhJIiUwY2I1ZDBhNjg1YzVjOGM0NDYxNjUxMTMxYmIxODMzMgY6BkVG--60137d05d2c5767b5b1a4e2572db0db57e736b91"

curl --include --request POST http://localhost:4741/events \
  --header "Authorization: Token token=BAhJIiU3MThlMDEyOGQzMWY1N2FmZmE5ZTRiOGMyOGQ3ZGFlMQY6BkVG--0786a1c2a93be0590c57c51f1a9ba433b0d4c7d8" \
  --header "Content-Type: application/json" \
  --data '{
    "event": {
      "songkick_id": "1234567890",
      "artists": ["the blah blahs", "the yea yeas","White Zombie"]
    }
  }'

create_table "events", force: :cascade do |t|
  t.text     "artists",     default: [],              array: true
  t.datetime "created_at",               null: false
  t.datetime "updated_at",               null: false
  t.datetime "start"
  t.datetime "end"
  t.string   "city"
  t.string   "country"
  t.string   "state"
  t.string   "event_name"
  t.integer  "event_id"
  t.string   "venue_name"
  t.integer  "venue_id"
  t.string   "region_name"
  t.integer  "region_id"
end


curl --include --request DELETE http://localhost:4741/events/4 \
--header "Authorization: Token token=BAhJIiU3MThlMDEyOGQzMWY1N2FmZmE5ZTRiOGMyOGQ3ZGFlMQY6BkVG--0786a1c2a93be0590c57c51f1a9ba433b0d4c7d8"
