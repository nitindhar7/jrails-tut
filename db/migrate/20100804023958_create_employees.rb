class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees, :options => "ENGINE=InnoDB" do |t|
      t.string :fname, :null => false, :limit => 30
      t.string :lname, :null => false, :limit => 30
      t.timestamps
    end
    
    add_index :employees, [:id, :fname, :lname, :created_at, :updated_at], :name => "employees_index"
  end

  def self.down
    remove_index :employees, "employees_index"
    drop_table :employees
  end
end
