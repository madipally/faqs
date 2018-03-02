class Subject < ApplicationRecord
    validates_presence_of :name, :description
end
