class CreateQueryAnalytics < ActiveRecord::Migration[7.0]
  def change
    create_table :query_analytics do |t|
      t.string :query
      t.string :ip_address

      t.timestamps
    end
  end
end
