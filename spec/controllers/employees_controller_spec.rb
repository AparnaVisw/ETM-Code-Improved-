require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let!(:user) { FactoryGirl.create(:employee) }
  describe 'POST #update' do
    context 'update record' do
      it 'updates existing employees' do
        employee1 = FactoryGirl.create(:employee)
        put :update, params: { id: employee1.id, user: { name: 'New Name', empid: 123, dob: '2016-09-06', address: 'ABCDEF' } }
        expect(Employee.where(id: employee1.id).first.name).to eq('New Name')
      end
    end
  end
end
