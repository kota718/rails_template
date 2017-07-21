# Rails template.

# .gitignore
run 'gibo macOS Ruby Rails JetBrains > .gitignore'

# Ruby version
ruby_version = `ruby -v`.scan(/\d\.\d\.\d/).flatten.first
insert_into_file 'Gemfile',%(

ruby '#{ruby_version}'), after: "source 'https://rubygems.org'"
run "echo '#{ruby_version}' > ./.ruby-version"
