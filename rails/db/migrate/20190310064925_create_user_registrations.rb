class CreateUserRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_registrations do |t|
      t.string :email, null: false
      t.string :confirmation_token, index: { unique: true }, null: false

      t.timestamps
    end
  end
end
