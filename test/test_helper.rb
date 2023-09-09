ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
#テストを色付きで表示するためのやーつ
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include ApplicationHelper #test環境でもApplicationヘルパーを使えるようにする

  #テストユーザがログイン中の場合はtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Add more helper methods to be used by all tests here...
end
