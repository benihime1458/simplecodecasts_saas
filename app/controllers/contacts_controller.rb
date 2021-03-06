class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    def create
        @contact = Contact.new(contact_params)
        
        if @contact.save
            #Mailer
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            ContactMailer.contact_email(name, email, body).deliver
            
            #alerts when form is submitted
            flash[:success] = 'Feedback sent!'
            redirect_to new_contact_path 
        else
            flash[:danger] = 'Error. Feedback not sent!'
            redirect_to new_contact_path 
        end
    end
    
    private 
        def contact_params
            params.require(:contact).permit(:name, :email, :comments) 
        end
end
