require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Mayito', email: 'mayito@gmail.com')
  end
  before { subject.save }

  it 'Name should not be blank' do
    subject.name = nil
    expect(subject).to_not be_blank
  end
end
