class AddCompleteToQueryAnalytic < ActiveRecord::Migration[7.0]
  def change
    add_column :query_analytics, :complete, :boolean, default: false
  end
end
