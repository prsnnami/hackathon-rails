class SymptomsController < ApplicationController
  before_action :set_symptom, only: [:show, :edit, :update, :destroy]

  # GET /symptoms
  # GET /symptoms.json
  def index
    @symptoms = Symptom.all
  end

  # GET /symptoms/1
  # GET /symptoms/1.json
  def show
    @symptom = Symptom.find(params[:id])
    @diseases = @symptom.diseases
    respond_to do |format|
      format.html
      format.xml { render :xml => @symptom}
    end 
  end

  # GET /symptoms/new
  def new
    @symptom = Symptom.new
    @diseases = Disease.all
  end

  # GET /symptoms/1/edit
  def edit

    @diseases = Disease.all
  end

  # POST /symptoms
  # POST /symptoms.json
  def create
    @symptom = Symptom.new(symptom_params)

    respond_to do |format|
      if @symptom.save
        format.html { redirect_to @symptom, notice: 'Symptom was successfully created.' }
        format.json { render :show, status: :created, location: @symptom }
      else
        format.html { render :new }
        format.json { render json: @symptom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /symptoms/1
  # PATCH/PUT /symptoms/1.json
  def update
    respond_to do |format|
      if @symptom.update(symptom_params)
        format.html { redirect_to @symptom, notice: 'Symptom was successfully updated.' }
        format.json { render :show, status: :ok, location: @symptom }
      else
        format.html { render :edit }
        format.json { render json: @symptom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /symptoms/1
  # DELETE /symptoms/1.json
  def destroy
    @symptom.destroy
    respond_to do |format|
      format.html { redirect_to symptoms_url, notice: 'Symptom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def search
    @diseases = Disease.includes(:symptoms).where('symptoms.id' => params[:symptom_ids])
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_symptom
      @symptom = Symptom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def symptom_params
      params.require(:symptom).permit(:name, {disease_ids:[]})
    end
end
