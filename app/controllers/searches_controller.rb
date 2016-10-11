class SearchesController < ApplicationController
  def index
    query = Searchkick.search params[:query], index_name: [Commodity, Brand, Standard], operator: "or"
    response = query.results.each_with_object([]) do |model,arr|
      arr << { id: model.id, name: "#{model.class.to_s} > #{model.name}", href: model_url(model)  }
    end
    render json: response
  end

  private

  def model_url(model)
    case model
      when Commodity
        commodity_url(model)
      when Brand
        brand_url(model)
      when Standard
        standard_url(model)
    end
  end
end
