curl --include --request POST http://localhost:4741/calendars \
  --header "Authorization: Token token=BAhJIiU3MTg5NTk0YzVkZTk2OTAxMDQ4ZDQ2ZWU3MWM2ZGFhOQY6BkVG--8d030ab48ebc6c270e8f47fea5b1e3e2bc8def41" \
  --header "Content-Type: application/json" \
  --data '{
    "calendar": {
      "isDone": false,
      "show_id": 3
    }
  }'

"BAhJIiVjZDZhNzg2NGU1OTZmYTc2ODYzOTBlN2JmYzQzYzcwNAY6BkVG--88f8edefd0c72b612cf238d49dec22c9e76351ba"

curl --include --request GET http://localhost:4741/calendars \
  --header "Authorization: Token token=BAhJIiU0NmVlNzNlOTdiZjcxMDQ1M2QxNTNlNzc5ZDgzYjRhZgY6BkVG--cb22be200e0ddca843e36051fbbf0a9f7a0d07b9" \
  --header "Content-Type: application/json" \


create_table "calendars", force: :cascade do |t|
  t.boolean  "isDone"
  t.integer  "event_id"
  t.integer  "user_id"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false


BAhJIiU0NmVlNzNlOTdiZjcxMDQ1M2QxNTNlNzc5ZDgzYjRhZgY6BkVG--cb22be200e0ddca843e36051fbbf0a9f7a0d07b9
