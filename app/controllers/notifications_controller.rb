class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = current_user.notifications.order("created_at ASC").paginate(:page => params[:page], :per_page => 20)
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

def frommod
  if params[:user_id] != current_user.id.to_s
    @notification = Notification.create(
      user_id: params[:user_id],
      body: "The mod #{current_user.name} sent you a message: #{params[:body]} <br> #{view_context.render 'notifications/formresponse', notification: @notification, user_id: current_user.id, flag_id: params[:flag_id]}",
      flag_id: params[:flag_id]
    )
  else
    @notification = Notification.create(
      user_id: params[:user_id],
      body: "MOD NOTE: #{current_user.name} said: #{params[:body]}",
      flag_id: params[:flag_id]
    )
  end
    @user = User.find_by_id(params[:user_id])
    @notification.save!
    respond_to do |format|
      if @notification.save
        format.html { redirect_to mod_url, notice: "Notification was successfully sent to #{@user.name}." }
        format.json { render :mod, status: :created, location: @notification }
      else
        format.html { render :mod }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
end

def tomod
  @notification = Notification.create(
    user_id: params[:user_id],
    body: "USER RESPONSE TO MOD NOTE: #{current_user.name} said: #{params[:body]}",
    flag_id: params[:flag_id]
  )

  @user = User.find_by_id(params[:user_id])
  @notification.save!
  respond_to do |format|
    if @notification.save
      format.html { redirect_to inbox_url, notice: "Response was successfully sent to #{@user.name}." }
      format.json { render :mod, status: :created, location: @notification }
    else
      format.html { render :mod }
      format.json { render json: @notification.errors, status: :unprocessable_entity }
    end
  end

end

def markread
  @notification = Notification.find_by_id(params[:id])
  @notification.toggle(:read).save
  respond_to do |format|
    if @notification.save
      format.html { redirect_to inbox_url, notice: "Marked read" }
      format.json { render :mod, status: :created, location: @notification }
    else
      format.html { render :mod }
      format.json { render json: @notification.errors, status: :unprocessable_entity }
    end
  end
end

def markallread
  @notifications = current_user.notifications.where(read: false)
  @notifications.each do |notification|
   notification.toggle(:read).save
 end
 respond_to do |format|
     format.html { redirect_to inbox_url, notice: "Marked read" }
     format.json { render :mod, status: :created, location: @notification }
 end
end


  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params)
    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notification_params
      params.require(:notification).permit(:user_id, :body, :flag_id, :read)
    end

end
