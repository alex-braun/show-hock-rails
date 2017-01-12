#!/bin/bash

API="http://localhost:4741"
URL_PATH="/sign-out"
curl "${API}${URL_PATH}/${ID}" \
  --include \
  --request DELETE \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN"

echo

API="http://localhost:4741"
URL_PATH="/sign-out"
curl "${API}${URL_PATH}/1" \
  --include \
  --request DELETE \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=BAhJIiViMTE2YjZmMWYxYjc4NGVmYmYwMzZjYmViYjgwZTYyOAY6BkVG--41184e5b96ca3ae49cf3e11b48ecf58a1ca44013"
