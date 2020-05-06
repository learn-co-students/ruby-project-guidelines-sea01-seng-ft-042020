class House < ActiveRecord::Base
    has_many :house_visits
    belongs_to :agent
    has_many :buyers, through: :house_visits
end