class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  

  # GET /products or /products.json
  
  def index
      @q = Product.ransack(params[:q])
      @products = @q.result
    
  end

  # GET /products/1 or /products/1.json
  def show
    
        Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
      session = Stripe::Checkout::Session.create({ 
        payment_method_types: [
        'card',
        ], 
         customer_email: current_user ? current_user.email : nil,
         line_items: [{
          price_data: { 
           unit_amount: (@product.price * 100).to_i,
            currency: "aud",
            product_data: {
            name: @product.name,
            description: @product.desription
           }
        },
         quantity: 1,
       }],
       payment_intent_data:{ 
         metadata: { 
           product_id: @product.id,
         }
       },
      mode: 'payment',
       success_url: "#{root_url}payments/success",
       cancel_url: "#{root_url}products",
     })
     @session_id = session.id
     
  end


  # GET /products/new
  def new
    @product = Product.new
  end

  

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_user_product
      @product = current_user.products.find_by_id(params[:id])
      redirect_to products_path
    end 

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :category, :user_id, :picture)
    end
end
