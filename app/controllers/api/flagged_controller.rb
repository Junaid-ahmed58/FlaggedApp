module Api
  class FlaggedController < ApplicationController
    before_action :find_flagger
    before_action :find_flaggable, only: [:create]

    def create
      @flagged = Flagged.new(flaggable: @flaggable, flagger: @flagger)

      if @flagged.save
        render json: @flagged, status: :created
      else
        render json: @flagged.errors, status: :unprocessable_entity
      end
    end

    private

    def find_flagger
      flagger_type = params[:flagger_type].capitalize
      @flagger = flagger_type.constantize.find(params[:flagger_id])
    end

    def find_flaggable
      flaggable_type = params[:flaggable_type].capitalize
      @flaggable = flaggable_type.constantize.find(params[:flaggable_id])
    end
  end
end
