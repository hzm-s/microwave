class CreateCancelledUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :cancelled_users do |t|
      t.references :user, type: :uuid, null: false, index: { unique: true }, foreign_key: true
      t.datetime :cancelled_at, null: false
    end
  end
end
