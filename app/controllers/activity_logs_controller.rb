class ActivityLogsController < ApplicationController
  before_action :set_activity_log, only: [:show, :update, :destroy]

  # GET /activity_logs
  def index
    
    has_filter = filter_params
    
    if has_filter.blank? # Si se desea retornar toda la data sin filtrar
      @activity_logs = ActivityLog.order(start_time: :desc).all
      
      if params[:baby_id].blank?
        render json: @activity_logs
      else
        render json: @activity_logs, rule: :hidden_fields
      end

    else # Si se desea retornar la data con filtros

      @activity_logs = ActivityLog.order(start_time: :desc).where(nil)
      @activity_logs = @activity_logs.filter_by_baby(params[:b]) if params[:b].present?
      @activity_logs = @activity_logs.filter_by_assistant(params[:a]) if params[:a].present?
      if params[:s].present?
        case params[:s].to_i
        when 2
          @activity_logs = @activity_logs.filter_by_terminated(nil)
        when 3
          @activity_logs = @activity_logs.filter_by_process(nil)
        end
      end
      
      render json: @activity_logs

    end
  end

  # GET /activity_logs/1
  def show
    render json: @activity_log
  end

  # POST /activity_logs
  def create
    @activity_log = ActivityLog.new(activity_log_params)

    if @activity_log.save
      render json: @activity_log, status: :created, location: @activity_log
    else
      render json: @activity_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activity_logs/1
  def update
    if @activity_log.update(activity_log_params)
      render json: @activity_log
    else
      render json: @activity_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /activity_logs/1
  def destroy
    @activity_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_log
      @activity_log = ActivityLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def activity_log_params
      params.require(:activity_log).permit(:baby_id, :assistant_id, :activity_id, :start_time, :stop_time, :duration, :comments)
    end

    def filter_params
      # Verifica si recibo algun parametro para filtrar
      valid = false
      valid = valid || params[:b].present?
      valid = valid || params[:a].present?
      valid = valid || params[:s].present?
      return valid
    end

end
