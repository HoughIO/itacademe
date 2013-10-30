class Studentname < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :firstname
      t.string :lastname
    end
  end
end
