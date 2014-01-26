class UniqueUserRoles < ActiveRecord::Migration
  def up
    User.connection.execute 'ALTER TABLE roles_users ADD CONSTRAINT role_user_constraint UNIQUE (role_id, user_id)'
  end

  def down
    User.connection.execute 'ALTER TABLE roles_users DROP CONSTRAINT role_user_constraint'
  end
end
