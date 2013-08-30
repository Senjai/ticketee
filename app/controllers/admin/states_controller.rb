class Admin::StatesController < Admin::BaseController
  def index
    @states = State.all
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(state_params)

    if @state.save
      redirect_to admin_states_path, notice: "State has been created."
    else
      flash.now[:alert] = "State has not been created."
      render action: :new
    end
  end

  def edit
    @state = State.find(params[:id])
  end

  def update
    @state = State.find(params[:id])

    @state.update(state_params)
    redirect_to admin_states_path
  end

  def destroy
    @state = State.find(params[:id])
    @state.destroy
    redirect_to admin_states_path
  end

  private

  def state_params
    params.require(:state).permit(:name)
  end
end
