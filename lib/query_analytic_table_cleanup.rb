# Purpose: This class is used to clean up the query_analytics table. 
#It will remove any incompleted queries. 
#For example, the query "what is" is contained within the query "what is a good car", then will be removed.
# Usage: QueryAnalyticTableCleanup.cleanup

class QueryAnalyticTableCleanup
  def self.cleanup
    queries = QueryAnalytic.order(updated_at: :desc)
  
    queries_to_destroy = []

    queries.each_cons(2) do |current_query, next_query|
      if current_query.query.downcase.gsub(/\s/, '').include?(next_query.query.downcase.gsub(/\s/, ''))
        queries_to_destroy << next_query
        current_query.update(complete: true)
      elsif next_query.query.downcase.gsub(/\s/, '').include?(current_query.query.downcase.gsub(/\s/, ''))
        queries_to_destroy << current_query
        next_query.update(complete: true)
      end
    end

    # Destroy the queries after the iteration
      queries_to_destroy.each(&:destroy)
  end
end