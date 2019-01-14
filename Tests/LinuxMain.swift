import XCTest

import ClientTests
import FunctionalTests
import KeyValueCodableTests
import MessageTests
import ServerTests

var tests = [XCTestCaseEntry]()
tests += ClientTests.__allTests()
tests += FunctionalTests.__allTests()
tests += KeyValueCodableTests.__allTests()
tests += MessageTests.__allTests()
tests += ServerTests.__allTests()

XCTMain(tests)
