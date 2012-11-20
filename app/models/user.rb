class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :token_authenticatable

  has_many :orders
  attr_accessible :stripe_customer_id, :name, :provider, :uid, :email, :password, :city, :state, :zip, :country

  def self.find_or_create_for_facebook_oauth(auth, signed_in_resource=nil)
    puts auth.to_yaml
    if user = User.where(:provider => auth.provider, :uid => auth.uid).first
      # User was created before. Just return him
      user
    elsif user = User.find_by_email(auth.info.email)
      # User was created by parsing email. Add missing attrbute.
      user.name = auth.extra.raw_info.name unless user.name
      user.provider = auth.provider unless user.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20] unless user.encrypted_password
      user.save!
      user
    else
      user = User.create!(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                         )
      user
    end
  end

  def self.find_or_create_by_email(email)
    if user = User.find_by_email(email)
      user
    else
      User.create email: email, password: Devise.friendly_token[0,20], uid: 88888888 # XXX
    end
  end

end
