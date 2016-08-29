class UnspscFamiliesController < ApplicationController
  before_action :logged_in_using_omniauth?

  def index
    respond_to do |format|
      format.json { render json: UnspscFamilyDatatable.new(view_context) }
    end
  end
end
