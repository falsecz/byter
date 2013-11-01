assert = require 'assert'
b = require '../'

describe "Convert", ->

	it "string to bytes and back", ->
		a = b.stringToBytes "mrdka"
		assert.strictEqual b.bytesToString(a), "mrdka"

	it "long to bytes and back", ->
		a = b.longToBytes 10
		(b.bytesToLong a).toString()
		assert.strictEqual (b.bytesToLong a).toString(), "10"

	it "long string to bytes and back", ->
		a = b.longToBytes "9223372036854775807"
		assert.strictEqual (b.bytesToLong a).toString(), "9223372036854775807"

	it "int string to bytes and back", ->
		a = b.intToBytes 10
		assert.strictEqual 10, b.bytesToInt a

	it "int string to bytes and back", ->
		a = b.intToBytes "10"
		assert.strictEqual 10,  b.bytesToInt a

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