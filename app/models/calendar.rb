class Calendar < ApplicationRecord
  belongs_to :user

  validates :title, length: { minimum: 3 }, presence: true
  validates :user, presence: true
end
