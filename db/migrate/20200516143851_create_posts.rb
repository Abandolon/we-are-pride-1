class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :prompt
      t.string :message
      t.string :timestamp
      t.string :location
    end
  end
end
