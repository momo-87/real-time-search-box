class SearchController < ApplicationController
  before_action :sanitize_query, only: [:search]
  
  def index
    @query_analytics = QueryAnalytic.where(complete: true).order(:updated_at)
  end

  def search
    # Retrieves the search query from the parameters sent with the request
    query = params[:query].to_s.strip
    ip_address = request.remote_ip

    # Save the search query and IP address to the database
    QueryAnalytic.create(query: query, ip_address: ip_address)

    render json: { message: 'Search recorded successfully' }
  end


  private

  def sanitize_query
    params[:query] = params[:query].to_s.strip
  end

  def query_params
    params.require(:query_analytics).permit(:query)
  end

end
