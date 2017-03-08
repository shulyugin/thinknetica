class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title,
            presence: true,
            length: { maximum: 150 }

  validates :body,
            presence: true,
            length: { maximum: 1000 }
end
