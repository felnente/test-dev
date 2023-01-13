class ContactsController < ApplicationController
  include Paginable
  

  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.search(params[:name]).page(current_page).per(per_page).sorted_by_name

    render json: @contacts, meta: meta_attributes(@contacts), adapter: :json
  end

  # GET /contacts/1
  def show
    render json: @contact
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params) 

    generic_create(@contact)
  end

  # PATCH/PUT /contacts/1
  def update
    generic_update(@contact, contact_params)
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:name, :cpf, :email, :birth)
    end
end
