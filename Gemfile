# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# A toolkit of support libraries and Ruby core extensions extracted from the Rails framework. (https://rubyonrails.org)
gem 'activesupport', '~> 6.0', require: false

# Emoji library (https://github.com/github/gemoji)
gem 'gemoji', require: false

group :test do

  # Code coverage for Ruby (https://github.com/simplecov-ruby/simplecov)
  gem 'simplecov', '~> 0.19.0'

  # rspec-3.9.0 (http://github.com/rspec)
  gem 'rspec', '~> 3.9'

end

group :docs do
  # Documentation tool for consistent and usable documentation in Ruby. (http://yardoc.org)
  gem "yard", require: false

  # TomDoc for YARD (http://rubyworks.github.com/yard-tomdoc)
  gem "yard-tomdoc", require: false

  # kramdown is a fast, pure-Ruby Markdown-superset converter. (http://kramdown.gettalong.org)
  gem "kramdown", require: false
end
