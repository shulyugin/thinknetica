require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'Associations' do
    it { should belong_to(:question) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(1000) }
  end
end
