require 'rails_helper'

RSpec.describe PayrollGenerationService do
  describe '#call' do
    subject(:service) { described_class.new }

    context 'when there are no existing payrolls' do
      before do
        allow(Payroll).to receive(:last).and_return(nil)
      end

      it 'creates a new payroll with correct dates' do
        payroll = service.call

        expected_starts_at = 2.months.ago.beginning_of_day
        expect(payroll.starts_at).to eq(expected_starts_at)
        expect(payroll.ends_at).to eq((payroll.starts_at + (PayrollGenerationService::END_DAY - payroll.starts_at.day).days) - 1.day)
      end
    end

    context 'when there is an existing payroll' do
      let!(:last_payroll) { create(:payroll, ends_at: Date.new(2024, 10, 4)) }

      it 'creates a new payroll with correct dates' do
        payroll = service.call

        expect(payroll.starts_at).to eq(last_payroll.ends_at + 1.day)
        expect(payroll.ends_at).to eq(last_payroll.ends_at + (PayrollGenerationService::END_DAY - PayrollGenerationService::START_DAY).days)
      end
    end
  end
end
