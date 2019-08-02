class ApplicationController < ActionController::API
  before_action :ensure_json_request

  # Return only if client accepts Mime Type vnd.api+json results
  def ensure_json_request
    return if request.headers["Accept"] =~ /json/
    render :nothing => true, :status => 406
  end
end
