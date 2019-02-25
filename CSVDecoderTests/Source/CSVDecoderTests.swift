//
//  CSVDecoderTests.swift
//  CSVDecoderTests
//
//  Created by Red Davis on 15/02/2019.
//  Copyright © 2019 Red Davis. All rights reserved.
//

import XCTest
@testable import CSVDecoder


internal class CSVDecoderTests: XCTestCase
{
    // MARK: Setup
    
    override func setUp()
    {

    }

    override func tearDown()
    {
        
    }

    // MARK: -
    
    internal func testDecoding()
    {
let data = """
name,age,city,postcode,birthplace
_why,45,Bath,BA15NF,
"""
        let decoder = CSVDecoder()
        
        do
        {
            let customer = try decoder.decode(Customer.self, from: data)
            XCTAssertEqual(customer.name, "_why")
            XCTAssertEqual(customer.age, 45)
            XCTAssertEqual(customer.city, "Bath")
            XCTAssertEqual(customer.postcode, "BA15NF")
            XCTAssertNil(customer.birthplace)
        }
        catch
        {
            print(error)
            XCTFail(error.localizedDescription)
        }
    }
    
    internal func testDecodingArray()
    {
        let data = """
name,age,city,postcode,birthplace
_why,45,Bath,,London
Red,15,Bath,BA15NF,London
"""
        let decoder = CSVDecoder()
        
        do
        {
            let customers = try decoder.decode([Customer].self, from: data)
            XCTAssertEqual(customers.count, 2)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
    
    internal func testKeyNotExisting()
    {
        let data = """
error,age,city,postcode,birthplace
_why,45,Bath,BA15NF,London
"""
        let decoder = CSVDecoder()
        
        do
        {
            _ = try decoder.decode(Customer.self, from: data)
            XCTFail()
        }
        catch let error as DecodingError
        {
            switch error
            {
            case .keyNotFound(let key, _):
                XCTAssertEqual(key.stringValue, "name")
            default:
                XCTFail("Incorrect error \(error)")
            }
        }
        catch
        {
            XCTFail("Incorrect error \(error)")
        }
    }
}


// MARK: Customer

internal struct Customer: Decodable
{
    // Internal
    internal let name: String
    internal let age: Int
    internal let city: String
    internal let postcode: String?
    internal let birthplace: String?
    
    // MARK: Coding Keys
    
    internal enum CodingKeys: String, CodingKey
    {
        case name
        case age
        case city
        case postcode
        case birthplace
    }
}
