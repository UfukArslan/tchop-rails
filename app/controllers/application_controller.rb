class ApplicationController < ActionController::Base
  # appele only_signed_in par défaut, donc login obligatoire
  #  -> pour les pages n'ayant pas besoin de login, indiquer skip_before_action + les méthodes concernées
  #     skip_before_action :only_signed_in, only: [:new, :create]
  before_action :only_signed_in

  add_flash_types :success, :danger
  helper_method :current_user, :user_signed_in?

  private

  # vérifie s'il y a 'auth' en session et si l'id est bon
  #  autrement, redirige vers la page de login
  def only_signed_in
    if !user_signed_in?
      redirect_to new_session_path, danger: "Veuillez vous connecter pour accéder à cette page."
    end
  end

  # permet de rediriger un user sur son profil s'il est déjà connecté
  #  et qu'il essaie de se rendre par exemple sur la page users/new
  def only_signed_out
    redirect_to profil_path if user_signed_in?
  end

  # Retourne le user actuellement connecté
  def current_user
    return nil if !session[:auth] || !session[:auth]["id"]
    return @_user if @_user

    # Préférer find_by_id() à find() car si rien n'est trouvé :
    #  find        retourne une exception
    #  find_by_id  retourne nil
    @_user = User.find_by_id(session[:auth]["id"])
  end

  # retourne true si le user est connecté
  def user_signed_in?
    !current_user.nil?
  end
end
