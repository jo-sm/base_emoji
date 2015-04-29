module BaseEmoji
	def self.decode_base36(enc)
		enc.to_i(36)
	end

	def self.decode_base36str(enc)
		if enc == ''
			return enc
		end

		enc = enc.to_i(36).to_s(2)
		padding = (enc.length / 8).ceil * 8 + 8

		enc.rjust(padding, '0').scan(/.{8}/).map{ |byte| 
			byte.to_i(2).chr(Encoding::UTF_8)
		}.join
	end

	def self.encode_base36(input=0)
		input.to_s(36)
	end

	def self.encode_base36str(input='')
		input.each_char.map { |char|
			char.ord.to_s(2).rjust(8, '0')
		}.join.to_i(2).to_s(36)
	end
end