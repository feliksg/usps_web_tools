require_relative 'spec_helper'

RSpec.describe USPSWebTools::Parameter do
  context 'Zip Code' do
    let(:id) {1}
    let(:zip5) {'94108'}
    let(:parameter) {USPSWebTools::Parameter::ZipCode.new(id: id, zip5: zip5)}
    it '#id' do
      expect(parameter.id).to eq(id)
    end
    it '#zip5' do
      expect(parameter.zip5).to eq(zip5)
    end
    it '#to_s' do
      expect(parameter.to_s).to eq("<ZipCode ID=\"1\"><Zip5>94108</Zip5></ZipCode>")
    end
  end
  context 'Address' do
    let(:id) {1}
    let(:firm_name) {''}
    let(:addr1) {'445 GRANT AVE'}
    let(:addr2) {'SUITE 700'}
    let(:city) {'SAN FRANCISCO'}
    let(:state) {'CA'}
    let(:urbanization) {nil}
    let(:zip5) {'94108'}
    let(:zip4) {nil}
    let(:parameter) {USPSWebTools::Parameter::Address.new(id: id, firm_name: firm_name, addr1: addr1, addr2: addr2, city: city, state: state, urbanization: urbanization, zip5: zip5, zip4: zip4)}
    it '#to_s' do
      expect(parameter.to_s).to eq("<Address ID=\"1\"><FirmName/><Address1>445 GRANT AVE</Address1><Address2>SUITE 700</Address2><City>SAN FRANCISCO</City><State>CA</State><Urbanization/><Zip5>94108</Zip5><Zip4/></Address>")
    end
  end
end