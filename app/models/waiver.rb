class Waiver < ApplicationRecord
  validates_inclusion_of :confirmation, :in => [true]
end
