//
//  PhoneNumber.swift
//  PhoneNumberKit
//
//  Created by Roy Marmelstein on 26/09/2015.
//  Copyright © 2015 Roy Marmelstein. All rights reserved.
//

import Foundation

/**
Parsed phone number object
 
- CountryCode: Country dialing code as an unsigned. Int.
- LeadingZero: Some countries (e.g. Italy) require leading zeros. Bool.
- NationalNumber: National number as an unsigned. Int.
- NumberExtension: Extension if available. String. Optional
- RawNumber: String used to generate phone number struct
- Type: Computed phone number type on access. Returns from an enumeration - PNPhoneNumberType.
*/
public struct PhoneNumber {
    public let numberString: String
    public let countryCode: UInt64
    public let leadingZero: Bool
    public let nationalNumber: UInt64
    public let numberExtension: String?
    public let type: PhoneNumberType
}

extension PhoneNumber : Equatable {

    public static func ==(lhs: PhoneNumber, rhs: PhoneNumber) -> Bool {
        return (lhs.countryCode == rhs.countryCode)
            && (lhs.leadingZero == rhs.leadingZero)
            && (lhs.nationalNumber == rhs.nationalNumber)
            && (lhs.numberExtension == rhs.numberExtension)
    }

}

extension PhoneNumber : Hashable {

    public var hashValue: Int {
        var hashValue = 0

        hashValue ^= Int(truncatingBitPattern: countryCode)
        hashValue ^= Int(truncatingBitPattern: nationalNumber)

        if MemoryLayout<Int>.size != MemoryLayout<Int64>.size {
            // On 32-bit arch, `nationalNumber` doesn't fit `Int`, and to calculate hash,
            // we need to shift the most significant bits.
            hashValue ^= Int(truncatingBitPattern: nationalNumber >> 32)
        }

        if let numberExtension = numberExtension {
            hashValue ^= numberExtension.hashValue
        }

        return hashValue
    }

}

/// In past versions of PhoneNumebrKit you were able to initialize a PhoneNumber object to parse a String. Please use a PhoneNumberKit object's methods.
public extension PhoneNumber {
    /**
    DEPRECATED. 
    Parse a string into a phone number object using default region. Can throw.
    - Parameter rawNumber: String to be parsed to phone number struct.
    */
    @available(*, unavailable, message: "use PhoneNumberKit instead to produce PhoneNumbers")
    public init(rawNumber: String) throws {
        assertionFailure(PhoneNumberError.deprecated.description)
        throw PhoneNumberError.deprecated
    }
    
    /**
    DEPRECATED.
    Parse a string into a phone number object using custom region. Can throw.
    - Parameter rawNumber: String to be parsed to phone number struct.
    - Parameter region: ISO 639 compliant region code.
    */
    @available(*, unavailable, message: "use PhoneNumberKit instead to produce PhoneNumbers")
    public init(rawNumber: String, region: String) throws {
        throw PhoneNumberError.deprecated
    }

}


