require 'rspec'
require 'Patterns/version'
include Patterns
require File.expand_path('../../test', __FILE__) +'/test_env.rb'

describe 'ObserverTests' do

  it 'should be able to add an observer and notify it of an event' do

    admin = Patterns::Admin.new('Chris', 'ccooper@sessionm.com')

    expect(admin.last_notification).to eql('No notifications received')
    expect(admin.last_event).to eql('No events received')

    user = Patterns::User.new('TestUser', 'test@sessionm.com', 'test_password')

    user.add_observer(admin)
    expect {user.change_password('new_test_password')}.to output.to_stdout

    expect(admin.last_notification).not_to eql('No notifications received')
    expect(admin.last_event).not_to eql('No events received')

  end

end