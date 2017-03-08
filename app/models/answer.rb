class Answer < ApplicationRecord
  belongs_to :question

  validates_presence_of :question

  validates :body,
            presence: true,
            length: { maximum: 1000 }
end
