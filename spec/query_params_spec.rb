require 'spec_helper'

describe QueryParams do
  
  let(:base_uri) { "http://domain.com/search" }
  subject { URI::QueryParams.new(base_uri) }

  describe '#build_uri' do
    let(:output) { subject.build_uri() }

    it 'with equal' do
      subject.equal("name", "James Rodrigues")
      expect(output).to eq "#{base_uri}?filters=name::eq(James Rodrigues)"
    end

    it 'with greater and equal' do
      subject.greater_and_equal("age", "10")
      expect(output).to eq "#{base_uri}?filters=age::ge(10)"
    end

    it 'with less and equal' do
      subject.less_and_equal("age", "59")
      expect(output).to eq "#{base_uri}?filters=age::le(59)"
    end

    it 'empty string' do
      expect(output).to eq base_uri
    end

    it 'from hash' do
      uri = URI::QueryParams.build_uri(base_uri: base_uri, filters: ["name  =  James Rodrigues", "age >= 10"])
      expect(uri).to eq "#{base_uri}?filters=name::eq(James Rodrigues)|age::ge(10)"
    end

    it 'from hash with all operators' do
      uri = URI::QueryParams.build_uri(base_uri: base_uri, filters: ["a = 1", "b <= 1", "c >= 1"])
      expect(uri).to eq "#{base_uri}?filters=a::eq(1)|b::le(1)|c::ge(1)"
    end

    it 'from simple condition' do
      uri = URI::QueryParams.build_uri(base_uri: base_uri, filters: "name  =  James Rodrigues")
      expect(uri).to eq "#{base_uri}?filters=name::eq(James Rodrigues)"
    end

    it 'from without base_uri' do
      uri = URI::QueryParams.build_uri(filters: "name = James Rodrigues")
      expect(uri).to eq "filters=name::eq(James Rodrigues)"
    end

    it 'with simple quote in condition' do
      uri = URI::QueryParams.build_uri(filters: 'name = "Jame\'s Rodrigues"')
      expect(uri).to eq "filters=name::eq(James Rodrigues)"
    end

    it 'with double quote in condition' do
      uri = URI::QueryParams.build_uri(filters: "name = 'James Rodrigues'")
      expect(uri).to eq "filters=name::eq(James Rodrigues)"
    end

    it 'should encode URL' do
      uri = URI::QueryParams.build_uri(filters: "desc = Programming Ruby: The Pragmatic Programmer's Guide")
      expect(uri).to eq "filters=desc::eq(Programming Ruby: The Pragmatic Programmers Guide)"
    end

    it 'invalid operator' do
      expect{ URI::QueryParams.build_uri(filters: "age <> 13") }.to raise_error(ArgumentError)
    end

    it 'invalid condition' do
      expect{ URI::QueryParams.build_uri(filters: "age=13") }.to raise_error(ArgumentError)
    end

    it 'full_text_search' do
      subject.full_text_search("James")
      expect(output).to eq "#{base_uri}?q=James"
    end

    it 'full_text_search on hash' do
      expect(URI::QueryParams.build_uri(q: "James")).to eq "q=James"
    end

    it 'filters is required' do
      expect{ URI::QueryParams.filters("") }.to raise_error(ArgumentError)
      expect{ URI::QueryParams.filters(nil) }.to raise_error(ArgumentError)
    end

    it 'should build filters from string' do
      uri = URI::QueryParams.filters("age = 18")
      expect(uri).to eq "age::eq(18)"
    end

    it 'should build filters from array' do
      uri = URI::QueryParams.filters(["age >= 18", "age <= 21"])
      expect(uri).to eq "age::ge(18)|age::le(21)"
    end

    it 'should build filter with between' do
      uri = URI::QueryParams.filters(["age BETWEEN 18 AND 21"])
      expect(uri).to eq "age::bt(18,21)"
    end
  end
end