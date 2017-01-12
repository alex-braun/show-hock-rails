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
