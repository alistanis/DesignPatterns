require 'rspec'
require 'Patterns/version'

Dir["#{File.expand_path('../../app/', __FILE__)}/**/*.rb"].each { |f| load(f) }

include Patterns

describe 'ObserverTests' do

  it 'should be able to add an observer and notify it of an event' do

    admin = Patterns::Admin.new('Chris', 'ccooper@sessionm.com')

    expect admin.last_notification == 'No notifications received'
    expect admin.last_event == 'No events received'

    user = Patterns::User.new('TestUser', 'test@sessionm.com', 'test_password')

    user.add_observer(admin)
    user.change_password('new_test_password')

    expect admin.last_notification != 'No notifications received'
    expect admin.last_event != 'No events received'

  end


end