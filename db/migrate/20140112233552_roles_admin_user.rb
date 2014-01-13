class RolesAdminUser < ActiveRecord::Migration
    def self.up
        Role.new(name: 'user').save!
        Role.new(name: 'administrator').save!
        Role.new(name: 'superuser').save!
    end

    def self.down
        Role.find_by_name('user').destroy!
        Role.find_by_name('administrator').destroy!
        Role.find_by_name('superuser').destroy!
    end
end
