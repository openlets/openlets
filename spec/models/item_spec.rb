require 'spec_helper'
require "cancan/matchers"

describe Item do

  let(:user) { FactoryGirl.create(:user) }
  
  before(:each) do
    @item = FactoryGirl.build(:item, user: user)
  end

  describe 'creating items' do
    it { expect{ @item.save! }.to change{ user.items.count }.from(0).to(1) }
  end


end