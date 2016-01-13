class StaticPagesController < ApplicationController
  def home
    @things = Thing.where(:erasure => false)
    @things= Thing.paginate(page: params[2])
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
end
