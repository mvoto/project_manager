RSpec.configure do |config|
  # Main References:
  # http://andredieb.com/5-ways-to-speedup-rails-feature-tests.html
  # https://quickleft.com/blog/five-capybara-hacks-to-make-your-testing-experience-less-painful
  # http://www.virtuouscode.com/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # config.before(:each, :js => true) do
  #   DatabaseCleaner.strategy = :truncation
  # end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
