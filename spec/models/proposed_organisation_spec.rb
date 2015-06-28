require 'rails_helper'

describe ProposedOrganisation, :type => :model do
  context 'with associated user' do
    let!(:proposed_org){FactoryGirl.create :proposed_organisation}
    let!(:owner){proposed_org.users.first}
    let(:new_org){proposed_org.accept_proposal}
    it 'retains associated user after approval' do
      expect(new_org.users.first).to eq owner
    end
    it 'returns an organisation' do
      expect(new_org.class).to eq Organisation
    end
    it 'expunges the proposed organisation' do
      expect(proposed_org.id).to eq new_org.id
      expect{ProposedOrganisation.find proposed_org.id}.to raise_error
    end
    [:name, :description, :address, :longitude, :latitude, :email, :postcode, :publish_email, :publish_phone,
    :donation_info, :website, :publish_address, :telephone].each do |attr|
      it "#{attr} is retained" do
        expect(new_org.send(attr)).to eq(proposed_org.send(attr))
      end
    end
  end

  context "without nonprofit status confirmed" do
    let(:proposed_org){FactoryGirl.build_stubbed :invalid_proposed_organisation, works_in_harrow: true}
    it {expect(proposed_org.invalid?).to be true}
  end

  context "without neither works in nor registered in Harrow confirmed" do
    let(:proposed_org){FactoryGirl.build_stubbed :invalid_proposed_organisation, non_profit: true}
    it {expect(proposed_org.invalid?).to be true}
  end

end