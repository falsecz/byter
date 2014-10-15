assert = require 'assert'
float = require 'float'
b = require '../'

describe "Convert", ->
	describe "string", ->
		it "to bytes and back", ->
			a = b.stringToBytes "mrdka"
			assert.strictEqual b.bytesToString(a), "mrdka"
		it "to bytes and back", ->
			a = b.stringToBytes 1413375639
			assert.strictEqual b.bytesToString(a), "1413375639"

	describe "long", ->
		it "to bytes and back", ->
			a = b.longToBytes 10
			assert.strictEqual (b.bytesToLong a).toString(), "10"


		it "int to bytes and back", ->
			a = b.longToBytes 1370969615000
			assert.strictEqual (b.bytesToLong a).toString(), "1370969615000"


		it "string to bytes and back", ->
			a = b.longToBytes "9223372036854775807"
			assert.strictEqual (b.bytesToLong a).toString(), "9223372036854775807"

	describe "string", ->
		it "string to bytes and back", ->
			a = b.intToBytes 10
			assert.strictEqual 10, b.bytesToInt a

		it "string to bytes and back", ->
			a = b.intToBytes "10"
			assert.strictEqual 10,  b.bytesToInt a

	describe "float", ->

		it "to bytes and back", ->
			a = b.floatToBytes 1.234
			assert.ok float.equals(1.2341,  b.bytesToFloat a)

		it "string to bytes and back", ->
			a = b.floatToBytes "1.234"
			assert.ok float.equals(1.2341,  b.bytesToFloat a)

	describe "bool", ->
		it "bool to bytes and back", ->
			assert.strictEqual true, b.bytesToBool b.boolToBytes true
			assert.strictEqual false, b.bytesToBool b.boolToBytes false

		it "bool as string to bytes and back", ->
			assert.strictEqual true, b.bytesToBool b.boolToBytes "true"
			assert.strictEqual false, b.bytesToBool b.boolToBytes "false"

describe "Join bytes", ->

	it "two", ->
		a = b.intToBytes "2"
		aa = b.intToBytes "3"
		assert.strictEqual b.join(a, aa).length, 8

	it "three or more", ->
		a = b.intToBytes "2"
		aa = b.intToBytes "3"
		aaa = b.longToBytes "10"
		assert.strictEqual b.join(a, aa, aaa).length, 16