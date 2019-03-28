//
//  ObjectObjectWrapper.swift
//  OrderedObjectSet
//
//  Created by Bradley Hilton on 2/22/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

struct ObjectWrapper : Hashable {
    
    let object: AnyObject
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(Unmanaged.passUnretained(object).toOpaque().hashValue)
    }

    
    init(_ object: AnyObject) {
        self.object = object
    }
    
}

func ==(lhs: ObjectWrapper, rhs: ObjectWrapper) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
