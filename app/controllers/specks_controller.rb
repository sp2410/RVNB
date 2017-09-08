class SpecksController < ApplicationController
  before_action :set_speck, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /specks
  # GET /specks.json
  def index
    @specks = Speck.all
  end

  # GET /specks/1
  # GET /specks/1.json
  def show
  end

  # GET /specks/new
  def new
    @speck = Speck.new    
    @listing = Listing.find_by_id(params[:listing_id])
  end

  # GET /specks/1/edit
  def edit
  end

  # POST /specks
  # POST /specks.json
  def create

  	@listing = Listing.find_by_id(params[:listing_id])
    @speck = Speck.new speck_params.merge! listing_id: @listing.id


    respond_to do |format|
      if @speck.save
        format.html { redirect_to @listing, notice: 'Speck was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @speck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /specks/1
  # PATCH/PUT /specks/1.json
  def update
    respond_to do |format|
      if @speck.update(speck_params)
        format.html { redirect_to @speck, notice: 'Speck was successfully updated.' }
        format.json { render :show, status: :ok, location: @speck }
      else
        format.html { render :edit }
        format.json { render json: @speck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specks/1
  # DELETE /specks/1.json
  def destroy
    @speck.destroy
    respond_to do |format|
      format.html { redirect_to specks_url, notice: 'Speck was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_speck
      @speck = Speck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def speck_params
      params.require(:speck).permit(:name)
    end
end
