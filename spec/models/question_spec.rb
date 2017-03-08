require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'Associations' do
    describe 'Answer' do
      it { should have_many(:answers).dependent(:destroy) }
    end
  end

  describe 'Validations' do
    describe 'Title' do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title).is_at_most(150) }
    end
    describe 'Body' do
      it { should validate_presence_of(:body) }
      it { should validate_length_of(:body).is_at_most(1000) }
    end
  end
end
