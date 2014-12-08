class UserFlowsController < ApplicationController
  before_action :authenticate_user!
  before_action :enforce_policy
  respond_to :json

  def index
    respond_with current_user.user_flows, meta: potential_flows
  end

  def show
    respond_with UserFlow.find(params[:id])
  end

  def create
    flow = Flow.find(flow_params[:flow_id])
    user_flows = current_user.flows << flow
    render json: user_flows
  end

  def destroy
    user_flows = current_user.user_flows.find(params[:id])
    user_flows.destroy
    respond_with user_flows
  end

  def authorization
    head 204
  end

  private

  def flow_params
    params.require(:user_flow).permit(:flow_id)
  end

  def formatted_title
    flow_params[:title].downcase.capitalize
  end

  def potential_flows
    flows = (current_user.flows + Flow.defaults).map do |flow|
      { flow_id: flow.id, title: flow.title }
    end

    { flows: flows.uniq }
  end
end
