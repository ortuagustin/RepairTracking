module FiltersModels
  extend ActiveSupport::Concern

  included do
    helper_method :filter
  end

  def filter
    filter_params[:q]
  end

  def filter_params
    params.permit(:q)
  end
end