class OkComputerController < ActionController::Base
  if OKComputer.requires_authentication?
    http_basic_authenticate_with name: OKComputer.username, password: OKComputer.password
  end
  layout nil
  respond_to :text, :json

  def index
    checks = OKComputer::Registry.all
    checks.run

    respond_with checks, status: status_code(checks)
  end

  def show
    check = OKComputer::Registry.fetch(params[:check])
    check.run

    respond_with check, status: status_code(check)
  end

  def status_code(check)
    check.success? ? :ok : :error
  end
  private :status_code
end
