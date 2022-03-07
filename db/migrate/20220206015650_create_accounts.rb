class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.references :active_user, null: false, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.timestamps
    end

    add_index :accounts, [:active_user_id, :provider], unique: true
    add_index :accounts, [:provider, :uid]
  end
end
