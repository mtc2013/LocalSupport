class SessionsController < Devise::SessionsController

  def create
    super
    if params[:pending_organization_id] && current_user
      current_user.request_admin_status params[:pending_organization_id]
    end
  end
end
