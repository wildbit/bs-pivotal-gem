require 'helper'

class UsersTest < PivotalTestCase
  def test_account_memberships
    VCR.use_cassette('users') do
      @client.users(@account_id).each do |user|
        assert_not_nil user.id, "User's ID was nil"
        assert_not_nil user.username, "User's username was nil"
        assert_not_nil user.name, "User's name was nil"
        assert_not_nil user.initials, "User's initials was nil"
      end
    end
  end

  def test_single_user
    VCR.use_cassette('user') do
      user = @client.user(@account_id, @user_id)

      assert_not_nil user.id, "User's ID was nil"
      assert_not_nil user.username, "User's username was nil"
      assert_not_nil user.name, "User's name was nil"
      assert_not_nil user.initials, "User's initials was nil"
    end
  end

  def test_matches
    user = Pivotal::User.new(1, "Chris Ledet", "chrisledet", "CL")
    assert user.matches?("Chris Ledet")
    assert user.matches?("CL")
    assert user.matches?("chrisledet")
    refute user.matches?("XYZ")
    refute user.matches?("Ledet Chris")
    refute user.matches?("ledetchris")
  end
end
