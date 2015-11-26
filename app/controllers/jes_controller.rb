class JesController < ApplicationController
  before_action :set_je, only: [:show, :edit, :update, :destroy]

  # GET /jes
  # GET /jes.json
  def index
    @jes = Je.all
  end

  # GET /jes/1
  # GET /jes/1.json
  def show
  end

  # GET /jes/new
  def new
    @je = Je.new
  end

  # GET /jes/1/edit
  def edit
  end

  # POST /jes
  # POST /jes.json
  def create
    @je = Je.new(je_params)

    respond_to do |format|
      if @je.save
        format.html { redirect_to @je, notice: 'Je was successfully created.' }
        format.json { render :show, status: :created, location: @je }
      else
        format.html { render :new }
        format.json { render json: @je.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jes/1
  # PATCH/PUT /jes/1.json
  def update
    respond_to do |format|
      if @je.update(je_params)
        format.html { redirect_to @je, notice: 'Je was successfully updated.' }
        format.json { render :show, status: :ok, location: @je }
      else
        format.html { render :edit }
        format.json { render json: @je.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jes/1
  # DELETE /jes/1.json
  def destroy
    @je.destroy
    respond_to do |format|
      format.html { redirect_to jes_url, notice: 'Je was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_je
      @je = Je.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def je_params
      params.require(:je).permit(:name)
    end
end
