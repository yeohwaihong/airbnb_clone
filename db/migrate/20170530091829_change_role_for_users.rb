class ChangeRoleForUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :role, 'integer USING CAST(role AS integer)'

  end
end
