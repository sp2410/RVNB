class PaymentsController < InheritedResources::Base
	before_action :set_payment, only: [:edit, :update, :destroy]
	before_action :authenticate_user!

  # GET /payments/new
  def new
    @payment = Payment.new
    flash[:notice] = "Step 1: Please fill in the form below and click submit to proceed "
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    @payment.user_id = current_user.id

    respond_to do |format|
      if @payment.save

        # format.html { redirect_to @payment, notice: 'payment was successfully created.' }
        format.html { redirect_to edit_user_registration_path, notice: 'Payment was successfully saved!' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to edit_user_registration_path, notice: 'Payment was successfully updated' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to edit_user_registration_path, notice: 'payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 


  private

    def payment_params
      params.require(:payment).permit(:contact_number, :paypal_email, :billing_name, :billing_street_address, :billing_city, :billing_state)
    end

    def set_payment
    	@payment = Payment.find(params[:id])
    end
end

