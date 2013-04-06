chai = require "chai"

chai.should()

foo = ['asd', 'qwe']
foo.should.be.a 'array'
foo.should.have.length 3
