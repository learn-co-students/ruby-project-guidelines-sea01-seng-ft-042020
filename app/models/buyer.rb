class Buyer < ActiveRecord::Base
    has_many :house_visits
    has_many :houses, through: :house_visits
end