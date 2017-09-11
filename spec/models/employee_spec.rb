require 'rails_helper'

RSpec.describe Employee, type: :model do
  it 'is not valid without a valid name' do
    employee = Employee.new(name: nil)
    expect(employee).to_not be_valid
  end

  it 'is not valid without a valid date_of_birth' do
    employee = Employee.new(dob: nil)
    expect(employee).to_not be_valid
  end

  it 'is not valid without a valid empid' do
    employee = Employee.new(empid: nil)
    expect(employee).to_not be_valid
  end

  it 'is not valid without a valid address' do
  	employee = Employee.new(address: nil)
    expect(employee).to_not be_valid
  end

  it "should have many timesheets" do
    t = Employee.reflect_on_association(:timesheets)
    expect(t.macro).to eq(:has_many)
  end

end
