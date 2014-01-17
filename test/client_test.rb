require 'helper'

class ClientTest < Test::Unit::TestCase
  def setup
    token = "7d2d06f6381f9be18833d44c9361828c"
    @client = Pivotal::Client.new(token)
  end

  def test_projects
    @client.projects.each do |project|
      assert_not_nil project.id
      assert_not_nil project.name
    end
  end

  def test_single_project
    project = @client.project(987666)
    assert_not_nil project.id
    assert_not_nil project.name
  end

  def test_accounts
    @client.accounts.each do |account|
      assert_not_nil account.id
      assert_not_nil account.name
    end
  end

  def test_single_account
    account = @client.account(535789)
    assert_not_nil account.id
    assert_not_nil account.name
  end
end
