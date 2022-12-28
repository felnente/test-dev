class AddressesController < ApplicationController
  include Paginable

  before_action :set_address, only: [:show, :update, :destroy]

  # GET /addresses
  def index
    @addresses = Address.page(current_page).per(per_page)

    render json: @addresses, meta: meta_attributes(@addresses), adapter: :json
  end

  # GET /addresses/1
  def show
    render json: @address
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)

    if @address.save
      render json: @address, status: :created, location: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:cep, :street, :number, :district, :city, :state, :contact_id)
    end
end
