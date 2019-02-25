//
//  SingleValueContainer.swift
//  CSVDecoder
//
//  Created by Red Davis on 17/02/2019.
//  Copyright © 2019 Red Davis. All rights reserved.
//

import Foundation


internal extension _CSVDecoder
{
    internal final class SingleValueContainer
    {
        // Internal
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

// MARK: SingleValueDecodingContainer

extension _CSVDecoder.SingleValueContainer: SingleValueDecodingContainer
{
    func decodeNil() -> Bool
    {
        fatalError("Not implemented")
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable
    {
        fatalError("Not implemented")
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable, T: LosslessStringConvertible
    {
        fatalError("Not implemented")
    }
}
