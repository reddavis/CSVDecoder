//
//  CSVDecoder.swift
//  CSVDecoder
//
//  Created by Red Davis on 15/02/2019.
//  Copyright © 2019 Red Davis. All rights reserved.
//

import Foundation


public final class CSVDecoder
{
    // Private
    private var headers = [Header]()
    private var rows = [String]()
    
    // MARK: Decode
    
    public func decode<T>(_ type: T.Type, from string: String) throws -> T where T: Decodable
    {
        var rows = string.split(separator: "\n")
        let firstLine = rows.removeFirst()
        
        let headers = firstLine.split(separator: ",").enumerated().map({ (index, subSequence) -> Header in
            return Header(key: String(subSequence), index: index)
        })
        
        let remainingRows = rows.map { (substring) -> String in
            return String(substring)
        }
        
        let decoder = _CSVDecoder(headers: headers, rows: remainingRows)
        return try T(from: decoder)
    }
}


// MARK: Error

internal extension CSVDecoder
{
    internal enum Error: Swift.Error
    {
        case noHeaders
    }
}


// MARK: _CSVDecoder

internal final class _CSVDecoder
{
    // Internal
    public var codingPath = [CodingKey]()
    public var userInfo = [CodingUserInfoKey : Any]()
    
    // Private
    private let headers: [Header]
    private let rows: [String]
    
    // MARK: Initialization
    
    internal required init(headers: [Header], rows: [String])
    {
        self.headers = headers
        self.rows = rows
    }
}

// MARK: Decoder

extension _CSVDecoder: Decoder
{
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey
    {
        let row = self.rows.first ?? ""
        let container = KeyedContainer<Key>(headers: self.headers, row: row, codingPath: self.codingPath)
        return KeyedDecodingContainer(container)
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer
    {
        let container = UnkeyedContainer(headers: self.headers, rows: self.rows, codingPath: self.codingPath)
        return container
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer
    {
        return SingleValueContainer(headers: self.headers, rows: self.rows, codingPath: self.codingPath)
    }
}
