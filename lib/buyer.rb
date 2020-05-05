class Buyer < ActiveRecord::Base
    has_many :house_visits
    belongs_to :agent
    has_many :houses, through: :house_visits
end