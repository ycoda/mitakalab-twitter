class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         # :confirmable, :lockable, :timeoutable,
         :omniauthable, omniauth_providers: [:twitter]

  def self.find_for_twitter_oauth(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
    user = User.create( username: auth.info.name,
                        provider: auth.provider,
                        uid:      auth.uid,
                        email:    User.create_unique_email,
                        password: Devise.friendly_token[0,20]
                       )
    end
    user
  end

  # 通常サインアップ時のuid用、Twitter OAuth認証時のemail用にuuidな文字列を生成
  def self.create_unique_string
   SecureRandom.uuid
  end

  # twitterではemailを取得できないので、適当に一意のemailを生成
  def self.create_unique_email
   User.create_unique_string + "@example.com"
  end
end
