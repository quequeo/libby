source "https://rubygems.org"

gem "rails", "~> 7.2.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]
gem "bootsnap", require: false
gem "rack-cors"
gem "active_model_serializers", "~> 0.10.0"
gem "kaminari"
gem "byebug", platforms: %i[ mri mingw x64_mingw ]
gem "bcrypt", "~> 3.1.7"
gem "cancancan"

group :development do
  gem "dockerfile-rails", ">= 1.6"
  gem "bullet"
end

group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :test do
  gem "simplecov", require: false
  gem "database_cleaner"
  gem "shoulda-matchers"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
end
