class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 31, unique: true, index: true
      t.string :email, null: false, limit: 255, unique: true, index: true
      t.string :password_digest

      t.timestamps
    end
  end
end
