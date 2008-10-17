class PhoneEntriesController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.js { render(:layout => false) }
    end
  end

  def new
    @phone_entry = PhoneEntry.new

    respond_to do |format|
      format.html
      format.js { render(:layout => false) }
    end
  end
  
  def create
    @captcha_passed = captcha_pass?(params[:new_chunky], params[:new_bacon])
    if @captcha_passed
      @phone_entry = PhoneEntry.new(params[:phone_entry])
      @phone_entry_saved = @phone_entry.save
      if @phone_entry_saved
        flash[:notice] = "Novo número cadastrado com sucesso!"
      else
        flash[:notice] = 'Erro ao cadastrar novo número'
      end
    else
      flash[:notice] = "Novo número salvo com sucesso"
    end

    respond_to do |format|
      format.html { redirect :back }
      format.js { render(:layout => false) }
    end
  end
end
