require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "layout links" do
    get root_path
    assert_template 'static_pages/home' #正しくビューをレンダリングしてるか確認
    assert_select "a[href=?]", root_path, count: 2 #aboutへのリンクが2つあるかをチェックする
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")  #full_titleヘルパーを使用して、テストを書く(これだけだとヘルパーが間違っている説がある)
  end

  test "signup access" do
    get signup_path
  end
end
