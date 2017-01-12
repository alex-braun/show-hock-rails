#!/bin/bash

API="http://localhost:4741"
URL_PATH="/sign-up"
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
# URL_PATH="/sign-up"
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
