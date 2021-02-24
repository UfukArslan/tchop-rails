class PagesController < ApplicationController 

  def info

  end 

  def home

  end 

  def search 
    if params[:search].blank?  
      redirect_to(root_path, alert: "Empty field!") and return  
    else  
      @parameter = params[:search].downcase  
      @results = Restaurant.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")  
  
    end  
  end 

end 