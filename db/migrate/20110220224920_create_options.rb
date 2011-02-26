class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.string :symbol
      t.double :underlying
      t.double :strike
      t.double :time
      t.double :interest
      t.double :sigma
      t.double :dividend

      t.timestamps
    end
  end

  def self.down
    drop_table :options
  end
end
