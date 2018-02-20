import XCTest

import ServerTests
import MessageTests
import ClientTests
import FunctionalTests
import KeyValueCodableTests

var tests = [XCTestCaseEntry]()
tests += ServerTests.__allTests()
tests += MessageTests.__allTests()
tests += ClientTests.__allTests()
tests += FunctionalTests.__allTests()
tests += KeyValueCodableTests.__allTests()

XCTMain(tests)
