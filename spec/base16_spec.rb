require_relative '../lib/base_emoji/base16'

RSpec.describe 'BaseEmoji Base16 methods' do
	it 'properly encodes strings according to RFC 4648' do
		expect(BaseEmoji.to_base16).to eq ''
		expect(BaseEmoji.to_base16('')).to eq ''
		expect(BaseEmoji.to_base16('f')).to eq '66'
		expect(BaseEmoji.to_base16('fo')).to eq '666f'
		expect(BaseEmoji.to_base16('foo')).to eq '666f6f'
		expect(BaseEmoji.to_base16('foob')).to eq '666f6f62'
		expect(BaseEmoji.to_base16('fooba')).to eq '666f6f6261'
		expect(BaseEmoji.to_base16('foobar')).to eq '666f6f626172'
	end	

	it 'properly decodes encoded values according to RFC 4648' do
		expect(BaseEmoji.from_base16('666f6f626172')).to eq 'foobar'
		expect(BaseEmoji.from_base16('666f6f6261')).to eq 'fooba'
		expect(BaseEmoji.from_base16('666f6f62')).to eq 'foob'
		expect(BaseEmoji.from_base16('666f6f')).to eq 'foo'
		expect(BaseEmoji.from_base16('666f')).to eq 'fo'
		expect(BaseEmoji.from_base16('66')).to eq 'f'
	end
end