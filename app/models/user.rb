class User < ApplicationRecord

    has_secure_password
    has_secure_token :confirmation_token

    validates :username, 
        format: {with: /\A[a-zA-Z0-9_]{2,20}\z/, message: 'uniquement caractères alphanumériques ou _'}, 
        uniqueness: {case_sensitive: false}

    validates :email, 
        format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/}, 
        uniqueness: {case_sensitive: false}

    # converti un user en session, pour ensuite utiliser :
    # -> session[:auth] = @user.to_session
    def to_session
        {id: id}
    end 

end
