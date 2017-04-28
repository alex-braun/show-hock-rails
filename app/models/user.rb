# frozen_string_literal: true
class User < ActiveRecord::Base
  include Authentication
  has_many :calendars, dependent: :destroy
  has_many :shows, through: :calendars
end
