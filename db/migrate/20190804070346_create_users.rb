class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :pre_group_id
      t.integer :group_id
      t.integer :position_id
      t.integer :leader_flg

      t.timestamps
    end
  end
end
