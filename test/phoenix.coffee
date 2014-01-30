assert = require 'assert'
b = require '../'

describe "Phoenix data types", ->
	describe "double", ->
		it "to bytes zero", ->
			a = b.phoenix.toPDataDouble 0
			assert.equal "<Buffer 80 00 00 00 00 00 00 01>", a.inspect()

		it "to bytes small positive", ->
			a = b.phoenix.toPDataDouble 2.3
			assert.equal "<Buffer c0 02 66 66 66 66 66 67>", a.inspect()

		it "max double", ->
			a = b.phoenix.toPDataDouble 1.7976931348623157e308
			assert.equal "<Buffer ff f0 00 00 00 00 00 00>", a.inspect()

		it "max double", ->
			a = b.phoenix.toPDataDouble -1.7976931348623157e308
			assert.equal "<Buffer 00 10 00 00 00 00 00 01>", a.inspect()

		it "rounded number negative", ->
			a = b.phoenix.toPDataDouble -3467665
			assert.equal "<Buffer 3e b5 8b 37 80 00 00 00>", a.inspect()

		it "rounded number positive", ->
			a = b.phoenix.toPDataDouble 99427862
			assert.equal "<Buffer c1 97 b4 98 58 00 00 01>", a.inspect()

		it "PI as I remember", ->
			a = b.phoenix.toPDataDouble 3.1415926535897932384626
			assert.equal "<Buffer c0 09 21 fb 54 44 2d 19>", a.inspect()

	describe "unsigned integer", ->
		it "zero", ->
			a = b.phoenix.toPDataUnsignedInt 0
			assert.equal "<Buffer 00 00 00 00>", a.inspect()

		it "max value", ->
			a = b.phoenix.toPDataUnsignedInt 2147483647
			assert.equal "<Buffer 7f ff ff ff>", a.inspect()

		it "The answer", ->
			a = b.phoenix.toPDataUnsignedInt 42
			assert.equal "<Buffer 00 00 00 2a>", a.inspect()

	describe "signed integer", ->
		it "zero", ->
			a = b.phoenix.toPDataSignedInt 0
			assert.equal "<Buffer 80 00 00 00>", a.inspect()

		it "max int", ->
			a = b.phoenix.toPDataSignedInt 2147483647
			assert.equal "<Buffer ff ff ff ff>", a.inspect()

		it "min int", ->
			a = b.phoenix.toPDataSignedInt -2147483647
			assert.equal "<Buffer 00 00 00 01>", a.inspect()

		it "positive int", ->
			a = b.phoenix.toPDataSignedInt 3872
			assert.equal "<Buffer 80 00 0f 20>", a.inspect()

		it "negative int", ->
			a = b.phoenix.toPDataSignedInt -33557575
			assert.equal "<Buffer 7d ff f3 b9>", a.inspect()


	describe "toBytes", ->
		it "int", ->
			assert.deepEqual b.phoenix.intToBytes(10), [128, 0, 0, 10]

		it "negative int", ->
			assert.deepEqual b.phoenix.intToBytes(-10), [127,255,255,246]

		it "unsigned int", ->
			assert.deepEqual b.phoenix.unsignedIntToBytes(10), [0,0,0,10]

		it "date", ->
			assert.deepEqual b.phoenix.dateToBytes("1387547769000"), [128,0,1,67,16,74,184,168]

		it "long", ->
			assert.deepEqual b.phoenix.longToBytes("1387547769000"), [128,0,1,67,16,74,184,168]

		it "negative long", ->
			assert.deepEqual b.phoenix.longToBytes("-1387547769000"), [127,255,254,188,239,181,71,88]

		it "unsigned_long", ->
			assert.deepEqual b.phoenix.unsignedLongToBytes("1387547769000"), [0,0,1,67,16,74,184,168]

