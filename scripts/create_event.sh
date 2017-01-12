API="http://localhost:4741"
URL_PATH="/events"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=BAhJIiUwMmY1NzE5YjNjZjA3YWZhOGI5YjY2NDQzNGQwOTQ3ZQY6BkVG--0601e238e3293d117b7dcfda90187559b9971d68" \
  --data '{
    "event": {
      "songkick_id": "28268869",
      "name": "Atlas Lab at The Middle East Downstairs (January 11, 2017)",
      "location": "Cambridge, MA, US",
      "date": "2017-01-11T19:00:00-0500",
      "artists": ["Atlas Lab", "Fatty Lumpkins", "Arbuckle and the Furious Philanderers"]
    }
  }'
BAhJIiUwMmY1NzE5YjNjZjA3YWZhOGI5YjY2NDQzNGQwOTQ3ZQY6BkVG--0601e238e3293d117b7dcfda90187559b9971d68

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


# curl --include --request POST http://localhost:3000/cocktails \
#   --header "Authorization: Token token=BAhJIiVjMDgwNWE0ZmQ0NWFiMjUxZDcwOGQzOWY3YThhNGFmNQY6BkVG--a59cfdc486718a9ec3514073fbd00ab935d550a4" \
#   --header "Content-Type: application/json" \
#   --data '{
#     "cocktails": {
#       "name": "Whisky A Go-Go",
#       "category": "hard stuff",
#       "ingredients": "Ingredient 1", "ingredient 2", ingredient 3",
#       "directions": "Put 1 in 2", "put 2 in three", "put three in four",
#       "imageurl": "somplaceURL"
#     }
#   }'
#   attributes :id, :songkick_id, :name, :artists, :location, :date
#     has_many :users
