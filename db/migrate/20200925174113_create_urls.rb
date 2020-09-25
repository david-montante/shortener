class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.string :original_url, null: false

      t.timestamps
    end
  end
end
