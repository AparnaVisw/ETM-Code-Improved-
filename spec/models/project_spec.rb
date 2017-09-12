require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'should belong to employee' do
    t = Project.reflect_on_association(:employee)
    expect(t.macro).to eq(:belongs_to)
  end
end
