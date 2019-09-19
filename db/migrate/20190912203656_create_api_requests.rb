class CreateApiRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :api_requests do |t|
      t.text :url, null: false
      t.text :body, null: false
      t.timestamps
    end

    add_index :api_requests, :url, unique: true
  end
end
