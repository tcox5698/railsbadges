class RolesAdminUser < ActiveRecord::Migration
    def self.up
        Role.new(name: 'user').save!
        Role.new(name: 'administrator').save!
    end

    def self.down
        Role.find_by_name('user').destroy!
        Role.find_by_name('administrator').destroy!
    end
end
