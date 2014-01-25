require 'spec_helper'
require "cancan/matchers"

describe User do

  let(:guest_user){ nil }
  let(:user) { FactoryGirl.create(:user) }

  describe 'when is logged in' do
    subject(:ability){ Ability.new(user) }
    it { should be_able_to(:create, Item) }
  end

  describe 'guest user' do
    subject(:ability){ Ability.new(guest_user) }
    it { should_not be_able_to(:create, Item) }
  end

  describe 'Gifts' do
    binding.pry
    it 'should have 100 in budget after registration'
  end

end