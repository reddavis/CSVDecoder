//
//  Header.swift
//  CSVDecoder
//
//  Created by Red Davis on 25/02/2019.
//  Copyright © 2019 Red Davis. All rights reserved.
//

import Foundation


internal struct Header
{
    // Internal
    internal let key: String
    internal let index: Int
    
    // MARK: Initialization
    
    internal init(key: String, index: Int)
    {
        self.key = key
        self.index = index
    }
}
