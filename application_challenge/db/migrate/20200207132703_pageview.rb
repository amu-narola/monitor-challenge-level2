class Pageview < ActiveRecord::Migration[5.2]
  def up
    create_table :page_views do |t|
      t.bigint :visit_id
      t.string :title
      t.string :position
      t.text :url
      t.string :time_spent
      t.decimal :timestamp, precision: 14, scale: 3
    end
  end
end
