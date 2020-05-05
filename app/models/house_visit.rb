class HouseVisit < ActiveRecord::Base
    belongs_to :house
    belongs_to :buyer
end