Hanami::Model.migration do
  change do
    create_table :user_registrations do
      primary_key :id

      column :email, String, null: false
      column :confirmation_token, String, null: false, unique: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
