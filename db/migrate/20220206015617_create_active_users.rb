class CreateActiveUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :active_users do |t|
      t.references :user, type: :uuid, null: false, index: { unique: true }, foreign_key: true
      t.string :email, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :avatar_url, null: false

      t.timestamps
    end
  end
end
