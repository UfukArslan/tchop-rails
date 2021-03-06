class SessionsController < ApplicationController
  # évite le controle du login pour les méthodes indiquées -> voir ApplicationController
  skip_before_action :only_signed_in, only: [:new, :create]
  before_action :only_signed_out, only: [:new, :create]

  def new
  end

  def create
    user_params = params.require(:user)

    # on vérifie si le username ou l'email renseigné correspond à un User existant
    # si oui, on contrôle le password
    @user = User.where(username: user_params[:username]).or(User.where(email: user_params[:email])).first
    if @user && @user.authenticate(user_params[:password])
      session[:auth] = @user.to_session
      redirect_to profil_path, success: "Connexion réussie"
    else
      redirect_to new_session_path, danger: "Identifiants incorrects"
    end
  end

  def destroy
    session.destroy
    redirect_to new_session_path, success: "Vous êtes maintenant déconnecté"
  end
end
