require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('whatever@example.com').for(:email) }
    it { should_not allow_value('whatever').for(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_length_of(:password_confirmation).is_at_least(6) }
  end
end
