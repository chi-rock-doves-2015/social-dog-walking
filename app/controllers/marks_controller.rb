class MarksController < ActionController::Base
  respond_to :json 
  def create
  @walk = Walk.find_by(id: params[:walk_id])
    if request.xhr?
      @mark = Mark.new(mark_params)
      if @walk.marks << @mark
        format.json {render json: {response: 'this mark has been saved'}.to_json}
       render nothing
      else
        {response: 'mark has not been saved'}.to_json
      end
    end
  end

  private
    def mark_params
      params.require(:mark).permit(:accuracy, :latitude, :longitude)
    end
end
