class CreateActiveUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :active_users do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :email, null: false
      t.string :name, null: false
      t.string :initials, null: false

      t.timestamps
    end

    add_index :active_users, [:email], unique: true
  end
end
