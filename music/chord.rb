# Copyright (c) 2009-10-31 AOKI,Hanae
# <http://aereal.org/>
#
# License: <http://opensource.org/licenses/zlib-license.php>
#

module Music
	class Chord
		TONE_MAP = {
			"C" =>  0,
			"D" =>  2,
			"E" =>  4,
			"F" =>  5,
			"G" =>  7,
			"A" =>  9,
			"B" => 11,
		}
		
		SHARP = ["#"]
		FLAT  = ["b"]
		
		TONE_MAP.dup.each do |(k, v)|
			SHARP.each do |i|
				TONE_MAP[k + i] = v + 1
			end unless k == "E" || k == "B"
			FLAT.each do |i|
				TONE_MAP[k + i] = v - 1
			end unless k == "C" || k == "F"
		end
		
		def initialize(*args)
			@data = args.compact.uniq.map {|i| TONE_MAP[i].duo }
		end
		
		def inspect
			inverted = TONE_MAP.invert
			@data.map {|i| inverted[i] }.inspect
		end
		
		def to_s
			@data.inspect
		end
		
		def root
			@data.first
		end
		
		def major?
			@data.include?((root + 4).duo)
		end
		
		def minor?
			@data.include?((root + 3).duo)
		end
		
		def has_7th?
			@data.include?((root - 2).duo)
		end
		
		def has_9th?
			@data.include?((root + 2).duo)
		end
		
		def has_11th?
			@data.include?((root + 4).duo)
		end
		
		def diminished?
			@data.include?((root + 6).duo)
		end
		
		def augmented?
			@data.include?((root + 8).duo)
		end
	end
	
	class ::Fixnum
		def duo
			self % 12
		end
	end
end
