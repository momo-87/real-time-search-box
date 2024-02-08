# Purpose: This class is used to clean up the query_analytics table.
# It will remove any incomplete queries.
# An incomplete query is defined as a query that is a substring of another query within the same table.
# For example, the query "what is" within "what is a good car" will be removed.
# Usage: QueryAnalyticTableCleanup.cleanup
class QueryAnalyticTableCleanup
  def self.cleanup
    # Retrieve all query analytics records ordered by IP address and updated_at in descending order
    queries = QueryAnalytic.order(:ip_address, updated_at: :desc)

    # Array to store queries that need to be destroyed
    queries_to_destroy = []

    # Iterate through consecutive pairs of queries
    queries.each_cons(2) do |current_query, next_query|
      # Check if the current query is a substring of the next query
      if current_query.query.downcase.gsub(/\s/, '').include?(next_query.query.downcase.gsub(/\s/, ''))
        # If true, mark the next query as complete and add it to the list of queries to destroy
        queries_to_destroy << next_query
        current_query.update(complete: true)
      # Check if the next query is a substring of the current query
      elsif next_query.query.downcase.gsub(/\s/, '').include?(current_query.query.downcase.gsub(/\s/, ''))
        # If true, mark the current query as complete and add it to the list of queries to destroy
        queries_to_destroy << current_query
        next_query.update(complete: true)
      end
    end

    # Destroy the incomplete queries after the iteration
    queries_to_destroy.each(&:destroy)
  end
end
