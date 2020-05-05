class Agent < ActiveRecord::Base
    has_many :houses
    has_many :buyers
end