require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'appium_capybara'
require 'site_prism'

caps = Appium.load_appium_txt file: File.expand_path('./', 'appium.txt'), verbose: true

# CrossBrowserTesting App credentials
cbt_username = '' # YOUR CBT EMAIL HERE
cbt_authkey = '' # YOUR CBT AUTHKEY HERE

caps["cbt:options"] = {
  "name" => "Basic Test Example",
  "build" => "1.0",
  "deviceName" => "Pixel 4A",
  "platformVersion" => "11.0",
  "deviceOrientation" => "portrait",
  "record_video" => "true"
}

url = "http://#{cbt_username.sub('@', '%40')}:#{cbt_authkey}@hub.crossbrowsertesting.com/wd/hub"

Capybara.register_driver(:appium) do |app|
  all_options = caps.merge(appium_lib: { server_url: url }, global_driver: false)
  puts all_options.inspect

  Appium::Capybara::Driver.new app, **all_options
end

Capybara.default_driver = :appium
