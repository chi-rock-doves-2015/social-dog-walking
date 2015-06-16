
class MarksController < ApplicationController
  # respond_to :json

  def create
    @walk = Walk.find_by(id: params[:walk_id])
    puts params[:walk_id]
    puts mark_params.as_json
    puts "***************************************"
    if request.xhr?
      @mark = Mark.new(mark_params)
      if @walk.marks << @mark

        # format.json {render json: {response: 'this mark has been saved'}.to_json}
       render partial: 'walks/stats'

      else
        # figure out how to send an error.
      end
    else
      puts "NON XHR RECEIVED SOMEHOW!"
    end
  end

  private
    def mark_params
      params.require(:mark).permit(:accuracy, :coords)
    end
end
