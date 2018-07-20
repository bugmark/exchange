class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authenticate

  def execute
    variables      = ensure_hash(params[:variables])
    query          = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user,
    }
    result = BugmarkSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |mail, pass|
      puts "AUTHENTICATING: MAIL #{mail} PASS #{pass}"
      @current_user = User.find_by_email(mail)
      @current_user && @current_user.valid_password?(pass)
    end
  end

  def current_user
    @current_user
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: 500
  end
end
