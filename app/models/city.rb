class City < ApplicationRecord
    has_many :restaurants, inverse_of: :city
    accepts_nested_attributes_for :restaurants
end
