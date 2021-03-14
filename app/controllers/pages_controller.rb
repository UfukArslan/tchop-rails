class PagesController < ApplicationController
  # évite le controle du login pour les méthodes indiquées -> voir ApplicationController
  skip_before_action :only_signed_in

  def info
  end

  def home
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") && return
    else
      @parameter = params[:search].downcase
      @results = Restaurant.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")

    end
  end
end
