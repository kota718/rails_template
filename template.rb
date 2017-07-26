require 'bundler'

# .gitignore
run 'gibo macOS Ruby Rails JetBrains > .gitignore'

# Ruby version
ruby_version = `ruby -v`.scan(/\d\.\d\.\d/).flatten.first
insert_into_file 'Gemfile',%(

ruby '#{ruby_version}'), after: "source 'https://rubygems.org'"
run "echo '#{ruby_version}' > ./.ruby-version"

# add to Gemfile
append_file 'Gemfile', <<-CODE
gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'font-awesome-rails'
gem 'slim-rails'
gem 'simple_form'
gem 'seed-fu'
gem 'draper'
CODE

gem_group :development do
  gem 'bullet'
  gem 'overcommit', require: false
  gem 'bootsnap'
end


gem_group :development, :test  do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'pry-doc'
  gem 'tapp'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'hirb'
  gem 'hirb-unicode-steakknife'
  gem 'awesome_print'
  gem 'rails-flog'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'turnip'
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'slim_lint', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'bundle-audit', require: false
end

gem_group :test do
  gem 'webmock'
  gem 'vcr'
  gem 'timecop'
  gem 'faker'
  gem 'database_rewinder'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

Bundler.with_clean_env do
  run 'bundle install --path vendor/bundle --jobs=4 --without production'
end

run 'curl -s https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/ja.yml -o config/locales/ja.yml'
run 'curl -s https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/en.yml -o config/locales/en.yml'
run 'curl -s https://raw.githubusercontent.com/kota718/rails_template/master/config/initializers/generators.rb -o config/initializers/generators.rb'
run 'curl -s https://raw.githubusercontent.com/kota718/rails_template/master/config/initializers/locales.rb -o config/initializers/locales.rb'
run 'curl -s https://raw.githubusercontent.com/kota718/rails_template/master/config/initializers/timezone.rb -o config/initializers/timezone.rb'


generate 'simple_form:install --bootstrap'
generate 'draper:install'
generate 'rspec:install'

run 'curl -s https://raw.githubusercontent.com/kota718/rails_template/master/spec/turnip_helper.rb -o spec/turnip_helper.rb'
run 'curl -s https://raw.githubusercontent.com/kota718/rails_template/master/spec/support/capybara.rb -o spec/support/capybara.rb'
run 'curl -s https://raw.githubusercontent.com/kota718/rails_template/master/spec/support/database_rewinder.rb -o spec/support/database_rewinder.rb'
run 'curl -s https://raw.githubusercontent.com/kota718/rails_template/master/spec/support/factory_girl.rb -o spec/support/factory_girl.rb'
run 'curl -s https://raw.githubusercontent.com/kota718/rails_template/master/spec/support/shoulda_matchers.rb -o spec/support/shoulda_matchers.rb'

run 'rm -rf db/seed.rb'
run 'mkdir -p db/fixtures/test'
run 'touch db/fixtures/test/.keep'
run 'mkdir db/fixtures/development'
run 'touch db/fixtures/development/.keep'
run 'mkdir db/fixtures/production'
run 'touch db/fixtures/production/.keep'

gsub_file 'spec/rails_helper.rb', "# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }", "Dir[Rails.root.join('spec', 'support', '**', '*', '.rb')].each { |f| require f }"

insert_into_file '.rspec', <<-EOL
--color 
-f d 
-r turnip/rspec
EOL

insert_into_file 'config/environments/development.rb',%(
  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
  end
), after: 'config.assets.debug = true'

run 'bundle exec spring binstub --all'

run 'bundle exec rubocop --auto-correct'
run 'bundle exec rubocop --auto-gen-config'

git :init
git :add => '.'
git :commit => "-a -m 'First commit.'"
