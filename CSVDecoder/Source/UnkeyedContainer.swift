//
//  UnkeyedContainer.swift
//  CSVDecoder
//
//  Created by Red Davis on 17/02/2019.
//  Copyright © 2019 Red Davis. All rights reserved.
//

import Foundation


internal extension _CSVDecoder
{
    internal final class UnkeyedContainer
    {
        // Internal
        internal var currentIndex = 0
        internal let codingPath: [CodingKey]
        
        // Private
        private let headers: [Header]
        private let rows: [String]
        
        // MARK: Initialization
        
        internal required init(headers: [Header], rows: [String], codingPath: [CodingKey])
        {
            self.headers = headers
            self.rows = rows
            self.codingPath = codingPath
        }
    }
}

// MARK: UnkeyedDecodingContainer

extension _CSVDecoder.UnkeyedContainer: UnkeyedDecodingContainer
{
    var count: Int? {
        return self.rows.count
    }
    
    var isAtEnd: Bool {
        return self.currentIndex >= (self.count ?? 0)
    }
    
    func decodeNil() throws -> Bool
    {
        return !self.isAtEnd
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable
    {
        guard !self.isAtEnd else
        {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "no more values")
        }
        
        defer { self.currentIndex += 1 }
        
        let row = self.rows[self.currentIndex]
        let decoder = _CSVDecoder(headers: self.headers, rows: [row])
        
        return try T(from: decoder)
    }
    
    func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer
    {
        fatalError("Unimplemented")
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey
    {
        fatalError("Unimplemented")
    }
    
    func superDecoder() throws -> Decoder
    {
        fatalError("Unimplemented")
    }
}
