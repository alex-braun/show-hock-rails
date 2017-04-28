curl --include --request POST http://localhost:4741/performers \
  --header "Authorization: Token token=BAhJIiU5NmFhYzhmYmIyZGJkZjE5MGM0NWY0N2Q1NDQ0MDQ0NgY6BkVG--5c11e6ab002d3d4fb3ff32c47ab29b1ef812d13a" \
  --header "Content-Type: application/json" \
  --data '{
    "performer": {
      "show_id": 43,
      "artist_id": 5678,
      "artist_name": "Jimi Hendrix",
      "artist_img": "Hendrix.png"
    }
  }'

BAhJIiViOTA4ZWE4NmEyMmZiODc1MjRjOWY4NDkyZmQzYjU4NgY6BkVG
