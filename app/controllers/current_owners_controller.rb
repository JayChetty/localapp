class CurrentOwnersController < ApplicationController
  def index
    owner = current_owner
    respond_to do |format|
      format.json { render json: owner.to_json(methods: [:business]) }
    end
  end
end