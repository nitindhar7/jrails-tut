class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores, :options => "ENGINE=InnoDB" do |t|
      t.string :name, :null => false, :limit => 30
      t.string :city, :null => false, :limit => 30
      t.timestamps
    end
    
    add_index :stores, [:id, :name, :city, :created_at, :updated_at], :name => "stores_index"
  end

  def self.down
    remove_index :employees, "stores_index"
    drop_table :stores
  end
end
