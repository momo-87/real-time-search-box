# spec/controllers/search_controller_spec.rb
require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @query_analytics with completed queries ordered by updated_at' do
      # Manually create three completed query analytic records
      completed_queries = [
        QueryAnalytic.create!(query: 'Example Query 1', ip_address: '127.0.0.1', complete: true),
        QueryAnalytic.create!(query: 'Example Query 2', ip_address: '127.0.0.1', complete: true),
        QueryAnalytic.create!(query: 'Example Query 3', ip_address:'127.0.0.1', complete: true)
      ]

      get :index
      expect(assigns(:query_analytics)).to eq(completed_queries)
    end
  end

  describe 'POST #search' do
    it 'creates a new query analytic record' do
      expect {
        post :search, params: { query: 'Test Query'}
      }.to change(QueryAnalytic, :count).by(1)

      expect(response).to have_http_status(:success)
    end
  end
end
