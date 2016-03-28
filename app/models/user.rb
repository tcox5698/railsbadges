class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable; :lockable

  has_and_belongs_to_many :roles

  def update_roles(role_ids)
    self.roles.delete_all

    role_ids.each do |role|
      new_role = Role.find(role)
      self.roles << new_role
    end
  end

  #this method is called by devise to check for "active" state of the model
  def active_for_authentication?
    #remember to call the super
    #then put our own check to determine "active" state using
    #our own "is_active" column
    super and not self.disabled?
  end

end
