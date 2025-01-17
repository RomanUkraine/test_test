class PayrollGenerationService < ApplicationService
  START_DAY = 5
  END_DAY = 20

  def call
    starts_at, ends_at = calculate_payroll_dates
    create_payroll(starts_at, ends_at)
  end

  private

  def calculate_payroll_dates
    @last_payroll = Payroll.last

    if @last_payroll.nil?
      starts_at = 2.month.ago
      ends_at = (starts_at + (END_DAY - starts_at.day).days) - 1.day if 2.month.ago.day.between?(START_DAY, END_DAY)
    else
      starts_at = @last_payroll.ends_at + 1.day
      ends_at   = if @last_payroll.ends_at.day == START_DAY - 1 # when next payroll start day is 5th
                    @last_payroll.ends_at + (END_DAY - START_DAY).days
                  else
                    @last_payroll.ends_at.next_month.at_beginning_of_month + 3.days
                  end
    end

    [starts_at, ends_at]
  end

  def create_payroll(starts_at, ends_at)
    Payroll.new(starts_at:, ends_at:)
  end
end
