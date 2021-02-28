class UsersController < ApplicationController

    def new
        @user = User.new 
    end



    def create
        user_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
        @user = User.new(user_params)

        if @user.valid?
            @user.save
            UserMailer.confirm(@user).deliver_now
            redirect_to new_user_path, success: 'Votre compte a bien été créé, vous devriez recevoir un email pour confirmer votre compte. '
 
        else
            render 'new'
        end

    end 


    def confirm 
        @user = User.find(params[:id])
        if @user.confirmation_token == params[:token]
            @user.update_attribute(:confirmed, true)
            @user.update_attribute(:confirmation_token, nil)
            @user.save

            session[:auth] = {id: @user.id}
            redirect_to profil_path, success: 'Votre compte a bien été confirmé'

        else 
            redirect_to new_user_path, danger: 'Ce token ne semble pas valide' 
        end 
    end 


    def edit
        @user = User.find(session[:auth]['id'])
    end

    def update 
    end 

end 