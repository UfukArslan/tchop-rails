class ApplicationController < ActionController::Base
    # appele only_signed_in par défaut, donc login obligatoire
    #  -> pour les pages n'ayant pas besoin de login, indiquer skip_before_action + les méthodes concernées
    #     skip_before_action :only_signed_in, only: [:new, :create]
    before_action :only_signed_in 

    add_flash_types :success, :danger 


    private 

    # vérifie s'il y a 'auth' en session et si l'id est bon
    #  autrement, redirige vers la page de login
    def only_signed_in
        if !session[:auth] || !session[:auth]['id']
            redirect_to new_session_path, danger: "Veuillez vous connecter pour accéder à cette page."
        end 
    end 
end
