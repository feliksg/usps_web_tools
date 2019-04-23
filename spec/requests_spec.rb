require_relative 'spec_helper'

RSpec.describe USPSWebTools::Requests do
  let(:usps_user) {'usps_user'}
  let(:usps_pw) {'usps_password'}

  context 'City and State Lookup' do
    let(:parameter1) {USPSWebTools::Parameter::ZipCode.new(id: 1, zip5: '94108')}
    let(:parameter2) {USPSWebTools::Parameter::ZipCode.new(id: 1, zip5: '94014')}
    let(:parameters) {[parameter1, parameter2]}
    let(:requests) {USPSWebTools::Requests.new(api: 'CityStateLookupRequest', user_id: usps_user, password: usps_pw, parameters: parameters)}
    it 'should provide the url to USPS Web Tools for a request on city and state lookup' do
      expect(requests.to_url).to eq("https://secure.shippingapis.com/ShippingAPI.dll?API=CityStateLookup&XML=%3CCityStateLookupRequest%20USERID=%22usps_user%22%3E%3CRevision%3E1%3C/Revision%3E%3CZipCode%20ID=%221%22%3E%3CZip5%3E94108%3C/Zip5%3E%3C/ZipCode%3E%3CZipCode%20ID=%221%22%3E%3CZip5%3E94014%3C/Zip5%3E%3C/ZipCode%3E%3C/CityStateLookupRequest%3E")
    end
  end

  context 'zipcode lookup' do
    let(:primary_line) {'445 Grant Ave'}
    let(:secondary_line) {['Suite 700', ''].delete_if(&:empty?).join(',')}
    let(:city) {'SF'}
    let(:state) {'CA'}
    let(:parameter1) {USPSWebTools::Parameter::Address.new(id: 1, addr1: primary_line, addr2: secondary_line, city: city, state: state)}
    let(:parameters) {[parameter1]}
    let(:requests){USPSWebTools::Requests.new(api: 'ZipCodeLookupRequest', user_id: usps_user, password: usps_pw, parameters: parameters)}
    it 'should provide the url to USPS Web Tools for a request on zipcode lookup' do
      expect(requests.to_url).to eq("https://secure.shippingapis.com/ShippingAPI.dll?API=ZipCodeLookup&XML=%3CZipCodeLookupRequest%20USERID=%22usps_user%22%3E%3CRevision%3E1%3C/Revision%3E%3CAddress%20ID=%221%22%3E%3CFirmName/%3E%3CAddress1%3E445%20Grant%20Ave%3C/Address1%3E%3CAddress2%3ESuite%20700%3C/Address2%3E%3CCity%3ESF%3C/City%3E%3CState%3ECA%3C/State%3E%3CUrbanization/%3E%3CZip5/%3E%3CZip4/%3E%3C/Address%3E%3C/ZipCodeLookupRequest%3E")
    end
  end

  context 'address validate' do
    let(:primary_line) {'445 Grant Ave'}
    let(:secondary_line) {['', ''].delete_if(&:empty?).join(',')}
    let(:city) {'SF'}
    let(:state) {'CA'}
    let(:parameter1) {USPSWebTools::Parameter::Address.new(id: 1, addr1: primary_line, addr2: secondary_line, city: city, state: state)}
    let(:parameters) {[parameter1]}
    let(:requests){USPSWebTools::Requests.new(api: 'AddressValidateRequest', user_id: usps_user, password: usps_pw, parameters: parameters)}
    it 'should provide the url to USPS Web Tools for a request on zipcode lookup' do
      expect(requests.to_url).to eq("https://secure.shippingapis.com/ShippingAPI.dll?API=Verify&XML=%3CAddressValidateRequest%20USERID=%22usps_user%22%3E%3CRevision%3E1%3C/Revision%3E%3CAddress%20ID=%221%22%3E%3CFirmName/%3E%3CAddress1%3E445%20Grant%20Ave%3C/Address1%3E%3CAddress2%3ESuite%20700%3C/Address2%3E%3CCity%3ESF%3C/City%3E%3CState%3ECA%3C/State%3E%3CUrbanization/%3E%3CZip5/%3E%3CZip4/%3E%3C/Address%3E%3C/AddressValidateRequest%3E")
    end
  end
end