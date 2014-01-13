class AddSuperUser < ActiveRecord::Migration
    def up
        superuser = User.new(email: 'superuser@meritbadges.com',
            password: 'password',
            password_confirmation: 'password',
            confirmed_at: Time.now)
        superuser.roles << Role.find_by_name!('superuser')
        superuser.save!
    end

    def down
        superuser = User.find_by_email('superuser@meritbadges.com')
        superuser.roles.delete_all
        superuser.destroy!
    end
end
