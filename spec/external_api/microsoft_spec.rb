require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Microsoft do
  describe "#access" do
    subject { Microsoft.access }

    context 'Microsoft Api' do
      before do
        microsoft_api_request
      end

      it 'microsoft apiにアクセスする' do
        expect{ subject }.not_to raise_error
      end
    end
  end

  def microsoft_api_request
    WebMock.stub_request(:post, Settings.microsoft[:url])
    .to_return(
      status: 'OK',
      headers: { 'Content-Type' => 'application/json'}
    )
  end
end
