require_relative '../rails_helper'

RSpec.describe QueryAnalytic, type: :model do
  let(:search) { QueryAnalytic.create!(query: 'New query', ip_address: '127.0.0.1', complete: true) }

  describe 'validation' do
    it 'requires query to be present' do
      search.query = nil
      expect(search).not_to be_valid
    end

    it 'requires ip_address to be present' do
      search.ip_address = nil
      expect(search).not_to be_valid
    end
  end
end
