//
//  OrderedSet+CustomStringConvertible.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/19/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedSet : CustomStringConvertible, CustomDebugStringConvertible {
    
    /// A textual representation of `self`.
    public var description: String {
        return array.map { $0.object }.description
    }
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String {
        return array.map { $0.object }.debugDescription
    }
    
}