require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'Associations' do
    describe 'Question' do
      it { should belong_to(:question) }
      it { should validate_presence_of(:question) }
    end
  end

  describe 'Validations' do
    describe 'Body' do
      it { should validate_presence_of(:body) }
      it { should validate_length_of(:body).is_at_most(1000) }
    end
  end
end
