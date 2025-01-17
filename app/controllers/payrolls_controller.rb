class PayrollsController < ApplicationController
  before_action :new_payroll, only: %i[index create]

  def index
    @payrolls = Payroll.ordered.all
  end

  def create
    @payroll = PayrollGenerationService.call

    if @payroll.save
      flash[:success] = 'Payroll was successfully created.'
      redirect_to payrolls_path
    else
      @payrolls = Payroll.ordered.all
      flash.now[:error] = 'Payroll for future cannot be created.'
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @payroll = Payroll.find params[:id]
    return unless @payroll.destroy

    redirect_to :back
  end

  private

  def new_payroll
    @new_payroll = Payroll.new
  end
end
