module BaseEmoji
	# Uses Flickr alphabet
	ALPHABET_58 = '123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ'

	def self.decode_base58(enc=0)
		self._decode_base58(enc, Integer)
	end

	def self.decode_base58str(enc='')
		self._decode_base58(enc, String)
	end

	def self._decode_base58(enc, type)
		enc.reverse!

		i = enc.length - 1
		value = 0

		while i > 0
			value += self::ALPHABET_58.index(enc[i])
			value *= self::ALPHABET_58.length
			i-=1
		end

		value += self::ALPHABET_58.index(enc[0]) if enc[0]

		# only pad if there's a value to decode
		if type == String
			if value == 0
				return ''
			end

			padding = value > 0 ? (value.to_s(2).length / 8).ceil * 8 + 8 : 0
			value.to_s(2).rjust(padding, '0').scan(/.{8}/).map { |byte| 
				byte.to_i(2).chr(Encoding::UTF_8)
			}.join
		elsif type == Integer
			if value == 0
				return 1
			end

			value
		end
	end

	def self.encode_base58(input=0)
		div = input

		self._encode_base58(div)
	end

	def self.encode_base58str(input='')
		div = input.each_byte.map { |b| 
			b.to_s(2).rjust(8, '0')
		}.join.to_i(2)

		self._encode_base58(div)
	end

	def self._encode_base58(div) 
		result = []

		div, mod = div.divmod(58)
		result.push(self::ALPHABET_58[mod])

		while div != 0
			div, mod = div.divmod(58)
			result.push(self::ALPHABET_58[mod])
		end

		result.reverse.join
	end
end