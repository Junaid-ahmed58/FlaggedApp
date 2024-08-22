module Api
  class FlaggedController < ApplicationController
    before_action :find_flagger
    before_action :find_flaggable, only: [:create]

    def create
      if @flaggable.nil?
        render json: { error: "Flaggable not found." }, status: :not_found
        return
      end

      @flagged = Flagged.new(flaggable: @flaggable, flagger: @flagger)

      if @flagged.save
        @flaggable.update(flagged: true)
        render json: { message: "#{@flagger.class.name} flagged #{@flaggable.class.name} successfully." }, status: :ok
      else
        render json: { error: "Flagging failed." }, status: :unprocessable_entity
      end
    end

    private

    def find_flagger
      begin
        flagger_type = params[:flagger_type].capitalize
        @flagger = flagger_type.constantize.find(params[:flagger_id])

      rescue ActiveRecord::RecordNotFound
        render json: { error: "Flagger with ID #{params[:flagger_id]} not found." }, status: :unprocessable_entity
      end
    end

    def find_flaggable
      begin
        flaggable_type = params[:flaggable_type].capitalize
        @flaggable = flaggable_type.constantize.find(params[:flaggable_id])

      rescue ActiveRecord::RecordNotFound
        render json: { error: "Flaggable with ID #{params[:flaggable_id]} not found." }, status: :unprocessable_entity
      end
    end
  end
end
