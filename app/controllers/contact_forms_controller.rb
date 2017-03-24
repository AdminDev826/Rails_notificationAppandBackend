class ContactFormsController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    begin
      @contact_form = ContactForm.new(params[:contact_form])
      @contact_form.request = request
      if @contact_form.deliver
        flash.now[:notice] = 'Votre message a bien été reçu !'
      else
        render :new
      end
    rescue ScriptError
      flash[:error] = "Désolé ce message semble être un spam et n'a pas pu être délivré"
    end
  end
end
