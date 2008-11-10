class SearchesController < ApplicationController

  def new
    respond_to do |format|
      format.js { render(:layout => false) }
    end
  end

  def create
    @captcha_passed = captcha_pass?(params[:search_chunky], params[:search_bacon])
    if @captcha_passed
      @phone_entries = PhoneEntry.find_new_numbers(params[:search][:old_ddd], params[:search][:old_number])
    end

    respond_to do |format|
      format.js { render(:layout => false) }
    end
  end
end
