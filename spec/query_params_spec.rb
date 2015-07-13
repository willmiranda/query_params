require 'spec_helper'

describe QueryParams do
  
  let(:base_uri) { "http://domain.com/search" }
  subject { URI::QueryParams.new(base_uri) }

  describe '#build_uri' do
    let(:output) { subject.build_uri() }

    it 'with equal' do
      subject.equal("name", "James Rodrigues")
      expect(output).to eq "#{base_uri}?filters=name%3A%3Aeq%28James%20Rodrigues%29"
    end

    it 'with greater and equal' do
      subject.greater_and_equal("age", "10")
      expect(output).to eq "#{base_uri}?filters=age%3A%3Age%2810%29"
    end

    it 'with less and equal' do
      subject.less_and_equal("age", "59")
      expect(output).to eq "#{base_uri}?filters=age%3A%3Ale%2859%29"
    end

    it 'empty string' do
      expect(output).to eq base_uri
    end

    it 'from hash' do
      uri = URI::QueryParams.build_uri(base_uri: base_uri, conditions: ["name  =  James Rodrigues", "age >= 10"])
      expect(uri).to eq "#{base_uri}?filters=name%3A%3Aeq%28James%20Rodrigues%29%7Cage%3A%3Age%2810%29"
    end

    it 'from hash with all operators' do
      uri = URI::QueryParams.build_uri(base_uri: base_uri, conditions: ["a = 1", "b <= 1", "c >= 1"])
      expect(uri).to eq "#{base_uri}?filters=a%3A%3Aeq%281%29%7Cb%3A%3Ale%281%29%7Cc%3A%3Age%281%29"
    end

    it 'from simple condition' do
      uri = URI::QueryParams.build_uri(base_uri: base_uri, conditions: "name  =  James Rodrigues")
      expect(uri).to eq "#{base_uri}?filters=name%3A%3Aeq%28James%20Rodrigues%29"
    end

    it 'from without base_uri' do
      uri = URI::QueryParams.build_uri(conditions: "name = James Rodrigues")
      expect(uri).to eq "filters=name%3A%3Aeq%28James%20Rodrigues%29"
    end

    it 'with simple quote in condition' do
      uri = URI::QueryParams.build_uri(conditions: 'name = "Jame\'s Rodrigues"')
      expect(uri).to eq "filters=name%3A%3Aeq%28James%20Rodrigues%29"
    end

    it 'with double quote in condition' do
      uri = URI::QueryParams.build_uri(conditions: "name = 'James Rodrigues'")
      expect(uri).to eq "filters=name%3A%3Aeq%28James%20Rodrigues%29"
    end

    it 'should encode URL' do
      uri = URI::QueryParams.build_uri(conditions: "desc = Programming Ruby: The Pragmatic Programmer's Guide")
      expect(uri).to eq "filters=desc%3A%3Aeq%28Programming%20Ruby%3A%20The%20Pragmatic%20Programmers%20Guide%29"
    end

    it 'invalid operator' do
      expect{ URI::QueryParams.build_uri(conditions: "age <> 13") }.to raise_error(ArgumentError)
    end

    it 'invalid condition' do
      expect{ URI::QueryParams.build_uri(conditions: "age=13") }.to raise_error(ArgumentError)
    end

    it 'full_text_search' do
      subject.full_text_search("James")
      expect(output).to eq "#{base_uri}?q=James"
    end

    it 'full_text_search on hash' do
      expect(URI::QueryParams.build_uri(q: "James")).to eq "q=James"
    end
  end
end