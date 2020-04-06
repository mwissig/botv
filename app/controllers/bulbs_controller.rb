class BulbsController < ApplicationController
  before_action :set_bulb, only: [:show, :edit, :update, :destroy]
  before_action :find_bulbable, only: :create

  # GET /bulbs
  # GET /bulbs.json
  def index
    @bulbs = Bulb.all
  end

  # GET /bulbs/1
  # GET /bulbs/1.json
  def show
  end

  # GET /bulbs/new
  def new
    @bulb = Bulb.new
  end

  # GET /bulbs/1/edit
  def edit
  end

  # POST /bulbs
  # POST /bulbs.json
  def create
    @bulb = Bulb.new(bulb_params)

    respond_to do |format|
      if @bulb.save
        format.html { redirect_to @bulb, notice: 'Bulb was successfully created.' }
        format.json { render :show, status: :created, location: @bulb }
      else
        format.html { render :new }
        format.json { render json: @bulb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bulbs/1
  # PATCH/PUT /bulbs/1.json
  def update
    respond_to do |format|
      if @bulb.update(bulb_params)
        format.html { redirect_to @bulb, notice: 'Bulb was successfully updated.' }
        format.json { render :show, status: :ok, location: @bulb }
      else
        format.html { render :edit }
        format.json { render json: @bulb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulbs/1
  # DELETE /bulbs/1.json
  def destroy
    @bulb.destroy
    respond_to do |format|
      format.html { redirect_to bulbs_url, notice: 'Bulb was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bulb
      @bulb = Bulb.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bulb_params
      params.require(:bulb).permit(:color)
    end

    def find_bulbable
  if params[:comment_id]
    @bulbable = Comment.find_by_id(params[:comment_id])
  elsif params[:video_id]
    @bulbable = Video.find_by_id(params[:video_id])
  end
end
end
