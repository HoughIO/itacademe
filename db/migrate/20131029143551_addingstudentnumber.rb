class Addingstudentnumber < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :studentnumber
      t.string :classnumber
      t.boolean :maycontact, defalut: 'true'
    end
  end
end
