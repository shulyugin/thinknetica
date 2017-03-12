require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'Associations' do
    it { should have_many(:answers).dependent(:destroy) }
  end

  describe 'Validations' do
    context 'title' do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title).is_at_most(150) }
    end
    context 'body' do
      it { should validate_presence_of(:body) }
      it { should validate_length_of(:body).is_at_most(1000) }
    end
  end
end
