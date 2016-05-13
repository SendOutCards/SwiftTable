//
//  OrderedObjectSet+Set.swift
//  OrderedObjectSet
//
//  Created by Bradley Hilton on 2/20/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedObjectSet {
    
    public init(minimumCapacity: Int) {
        self.array = []
        self.set = Set(minimumCapacity: minimumCapacity)
        reserveCapacity(minimumCapacity)
    }

    /// Returns `true` if the ordered set contains a member.
    @warn_unused_result
    public func contains(member: Element) -> Bool {
        return set.contains(ObjectWrapper(member as! AnyObject))
    }
    
    /// Remove the member from the ordered set and return it if it was present.
    public mutating func remove(member: Element) -> Element? {
        guard let index = array.indexOf(ObjectWrapper(member as! AnyObject)) else { return nil }
        set.remove(ObjectWrapper(member as! AnyObject))
        return array.removeAtIndex(index).object as? Element
    }

    /// Returns true if the ordered set is a subset of a finite sequence as a `Set`.
    @warn_unused_result
    public func isSubsetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isSubsetOf(sequence.map { ObjectWrapper($0 as! AnyObject) })
    }

    /// Returns true if the ordered set is a subset of a finite sequence as a `Set`
    /// but not equal.
    @warn_unused_result
    public func isStrictSubsetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isStrictSubsetOf(sequence.map { ObjectWrapper($0 as! AnyObject) })
    }

    /// Returns true if the ordered set is a superset of a finite sequence as a `Set`.
    @warn_unused_result
    public func isSupersetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isSupersetOf(sequence.map { ObjectWrapper($0 as! AnyObject) })
    }

    /// Returns true if the ordered set is a superset of a finite sequence as a `Set`
    /// but not equal.
    @warn_unused_result
    public func isStrictSupersetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isStrictSupersetOf(sequence.map { ObjectWrapper($0 as! AnyObject) })
    }

    /// Returns true if no members in the ordered set are in a finite sequence as a `Set`.
    @warn_unused_result
    public func isDisjointWith<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isDisjointWith(sequence.map { ObjectWrapper($0 as! AnyObject) })
    }

    /// Return a new `OrderedObjectSet` with items in both this set and a finite sequence.
    @warn_unused_result
    public func union<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedObjectSet {
        return copy(self) { (inout set: OrderedObjectSet) in set.unionInPlace(sequence) }
    }
    
    /// Append elements of a finite sequence into this `OrderedObjectSet`.
    public mutating func unionInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        appendContentsOf(sequence)
    }

    /// Return a new ordered set with elements in this set that do not occur
    /// in a finite sequence.
    @warn_unused_result
    public func subtract<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedObjectSet {
        return copy(self) { (inout set: OrderedObjectSet) in set.subtractInPlace(sequence) }
    }

    /// Remove all members in the ordered set that occur in a finite sequence.
    public mutating func subtractInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        set.subtractInPlace(sequence.map { ObjectWrapper($0 as! AnyObject) })
        array = array.filter { set.contains($0) }
    }
    
    /// Return a new ordered set with elements common to this ordered set and a finite sequence.
    @warn_unused_result
    public func intersect<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedObjectSet {
        return copy(self) { (inout set: OrderedObjectSet) in set.intersectInPlace(sequence) }
    }
    
    /// Remove any members of this ordered set that aren't also in a finite sequence.
    public mutating func intersectInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        set.intersectInPlace(sequence.map { ObjectWrapper($0 as! AnyObject) })
        array = array.filter { set.contains($0) }
    }

    /// Return a new ordered set with elements that are either in the ordered set or a finite
    /// sequence but do not occur in both.
    @warn_unused_result
    public func exclusiveOr<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedObjectSet {
        return copy(self) { (inout set: OrderedObjectSet) in set.exclusiveOrInPlace(sequence) }
    }

    /// For each element of a finite sequence, remove it from the ordered set if it is a
    /// common element, otherwise add it to the ordered set. Repeated elements of the
    /// sequence will be ignored.
    public mutating func exclusiveOrInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        set.exclusiveOrInPlace(sequence.map { ObjectWrapper($0 as! AnyObject) })
        let (array, _) = collapse(self.array.map { $0.object as! Element } + sequence)
        self.array = array.filter { set.contains($0) }
    }
    
    /// If `!self.isEmpty`, remove the first element and return it, otherwise
    /// return `nil`.
    public mutating func popFirst() -> Element? {
        guard let first = array.first else { return nil }
        set.remove(first)
        return array.removeFirst().object as? Element
    }
    
}
