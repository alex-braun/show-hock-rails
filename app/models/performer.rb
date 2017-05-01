class Performer < ActiveRecord::Base
  belongs_to :show, foreign_key: :show_id
end
