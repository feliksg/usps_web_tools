require_relative 'spec_helper'

RSpec.describe USPSWebTools::Responses do
  context 'city and state lookup' do
    let(:xml_response) {'<?xml version="1.0" encoding="UTF-8"?><CityStateLookupResponse><ZipCode ID="1"><Zip5>94108</Zip5><City>SAN FRANCISCO</City><State>CA</State></ZipCode><ZipCode ID="1"><Zip5>94014</Zip5><City>DALY CITY</City><State>CA</State></ZipCode></CityStateLookupResponse>'}
    let(:responses) {USPSWebTools::Responses.new(xml: xml_response)}
    it 'should return the city' do
      expect(responses[0].city).to eq('SAN FRANCISCO')
    end
    it 'should return the state' do
      expect(responses[0].state).to eq('CA')
    end
  end

  context 'zipcode lookup' do
    let(:xml_response) {'<?xml version="1.0" encoding="UTF-8"?><ZipCodeLookupResponse><Address ID="1"><Address1>STE 700</Address1><Address2>445 GRANT AVE</Address2><City>SAN FRANCISCO</City><State>CA</State><Zip5>94108</Zip5><Zip4>3250</Zip4></Address></ZipCodeLookupResponse>'}
    let(:responses) {USPSWebTools::Responses.new(xml: xml_response)}
    it 'should return the zipcode-5' do
      expect(responses[0].zip5).to eq('94108')
    end
    it 'should return the zipcode-4' do
      expect(responses[0].zip4).to eq('3250')
    end
  end

  context 'address validate' do
    let(:xml_response) {'<?xml version="1.0" encoding="UTF-8"?><AddressValidateResponse><Address ID="1"><Address1>A</Address1><Address2>841 VALLEJO ST</Address2><City>SAN FRANCISCO</City><State>CA</State><Zip5>94133</Zip5><Zip4>3779</Zip4><DeliveryPoint>99</DeliveryPoint><ReturnText>Default address: The address you entered was found but more information is needed (such as an apartment, suite, or box number) to match to a specific address.</ReturnText><CarrierRoute>C019</CarrierRoute><Footnotes>BH</Footnotes><DPVConfirmation>D</DPVConfirmation><DPVCMRA>N</DPVCMRA><DPVFootnotes>AAN1</DPVFootnotes><Business>N</Business><CentralDeliveryPoint>N</CentralDeliveryPoint><Vacant>N</Vacant></Address><Address ID="2"><Error><Number>-2147219401</Number><Source>clsAMS</Source><Description>Address Not Found.  </Description><HelpFile/><HelpContext/></Error></Address><Address ID="3"><Address1>STE 700</Address1><Address2>445 GRANT AVE</Address2><City>SAN FRANCISCO</City><State>CA</State><Zip5>94108</Zip5><Zip4>3250</Zip4><DeliveryPoint>75</DeliveryPoint><CarrierRoute>C006</CarrierRoute><Footnotes>BN</Footnotes><DPVConfirmation>Y</DPVConfirmation><DPVCMRA>N</DPVCMRA><DPVFootnotes>AABB</DPVFootnotes><Business>Y</Business><CentralDeliveryPoint>Y</CentralDeliveryPoint><Vacant>N</Vacant></Address></AddressValidateResponse>'}
    let(:responses) {USPSWebTools::Responses.new(xml: xml_response)}
    it 'should have 2 responses' do
      expect(responses.size).to eq(3)
    end

    context 'valid but undeliverable address' do
      it 'should return text about insufficient information' do
        expect(responses[0].return_text).to eq('Default address: The address you entered was found but more information is needed (such as an apartment, suite, or box number) to match to a specific address.')
      end
      it '#deliverable?' do
        expect(responses[0].deliverable?).to be_falsey
      end
      it '#valid?' do
        expect(responses[0].valid?).to be_truthy
      end
      it '#error?' do
        expect(responses[0].error?).to be_falsey
      end
      it '#error_descriptions' do
        expect(responses[0].error_descriptions).to be_empty
      end
    end

    context 'not a valid address' do
      it 'should return text about insufficient information' do
        expect(responses[1].return_text).to be_nil
      end
      it '#deliverable?' do
        expect(responses[1].deliverable?).to be_falsey
      end
      it '#valid?' do
        expect(responses[1].valid?).to be_falsey
      end
      it '#error?' do
        expect(responses[1].error?).to be_truthy
      end
      it '#error_descriptions' do
        expect(responses[1].error_descriptions).to eq(['Address Not Found.  '])
      end
    end

    context 'valid and deliverable address' do
      it 'should return text about insufficient information' do
        expect(responses[2].return_text).to be_nil
      end
      it '#deliverable?' do
        expect(responses[2].deliverable?).to be_truthy
      end
      it '#valid?' do
        expect(responses[2].valid?).to be_truthy
      end
      it '#error?' do
        expect(responses[2].error?).to be_falsey
      end
      it '#error_descriptions' do
        expect(responses[2].error_descriptions).to be_empty
      end
    end
  end
end