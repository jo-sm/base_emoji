module BaseEmoji
	CHAR_ORDS = [
		128521, 
		127944, 
		128026, 
		128581, 
		128571, 
		128545, 
		128165, 
		127927, 
		9940, 
		128175, 
		128122, 
		127877, 
		127982, 
		11088, 
		128677, 
		128169, 
		127917, 
		128034, 
		128574, 
		127866, 
		128512, 
		128515, 
		128523, 
		9924, 
		128681, 
		9889, 
		128522, 
		128163, 
		128168, 
		127856, 
		127754, 
		127937, 
		128584, 
		127809, 
		127867, 
		128692, 
		128299, 
		127829, 
		128548, 
		128511, 
		127847, 
		128126, 
		127859, 
		127924, 
		128129, 
		128525, 
		128123, 
		127875, 
		128267, 
		128684, 
		128520, 
		127770, 
		128526, 
		128563, 
		127814, 
		128516, 
		127825, 
		128534, 
		128536, 
		128561
	]

	def self.encode_base_emoji(str='')
		# create a string of concatenated binary representations byte values, padded to ensure they are 8 bits
		# from the original string
		div = str.each_byte.map { |b| 
			b.to_s(2).rjust(8, '0')
		}.join.to_i(2)

		result = []

		while div != 0
			div, mod = div.divmod(60)
			result.push(self::CHAR_ORDS[mod].chr(Encoding::UTF_8))
		end

		# checksum is length of result + 3 % CHAR_ORDS length in emoji
		checksum = self::CHAR_ORDS[(result.length + 3) % 60].chr(Encoding::UTF_8)

		result.push(checksum).join
	end

	def self.decode_base_emoji(enc)
		# ensure that the checksum is valid
		if enc[-1] != self::CHAR_ORDS[(enc.length + 2) % 60].chr(Encoding::UTF_8)
			raise 'Invalid encoding'
		end

		enc.each_char do |char|
			raise 'Invalid encoding' if !self::CHAR_ORDS.index(char.ord)
		end

		# remove the last character
		enc = enc[0..-2]

		i = enc.length - 1
		value = 0

		while i > 0
			value += self::CHAR_ORDS.index(enc[i].ord)
			value *= 60
			i-=1
		end

		value += self::CHAR_ORDS.index(enc[0].ord) if enc[0]

		# only pad if there's a value to decode
		padding = value > 0 ? (value.to_s(2).length / 8).ceil * 8 + 8 : 0
		value.to_s(2).rjust(padding, '0').scan(/.{8}/).map { |byte| 
			byte.to_i(2).chr
		}.join
	end

end