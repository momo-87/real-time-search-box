require 'rails_helper'

RSpec.describe QueryAnalyticTableCleanup, type: :service do
  describe '.cleanup' do
    it 'removes incomplete queries and sets the completed query complete field to true' do
      query1 = QueryAnalytic.create!(query: 'what is', ip_address: '127.0.0.1')
      query2 = QueryAnalytic.create!(query: 'what is a good car', ip_address: '127.0.0.1')
      query3 = QueryAnalytic.create!(query: 'what is a good', ip_address: '127.0.0.1')

      # Trigger the cleanup process
      described_class.cleanup

      # waiting interval
      sleep(3)

      # Expectations
      query2.reload
      expect(query2.complete).to eq(true)
      expect(QueryAnalytic.exists?(query1.id)).to eq(false)
      expect(QueryAnalytic.exists?(query3.id)).to eq(false)
    end
  end
end
