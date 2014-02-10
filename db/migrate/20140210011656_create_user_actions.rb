class CreateUserActions < ActiveRecord::Migration
  def change
    create_table :user_actions do |t|
      t.string :name
      t.timestamp :action_date
      t.references :user, index: true

      t.timestamps
    end
  end
end
