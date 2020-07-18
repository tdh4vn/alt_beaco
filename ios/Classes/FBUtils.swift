//
//  FBUtils.swift
//  altbeacon
//
//  Created by HungTran on 7/18/20.
//

import Foundation
import CoreLocation

class FBUtils {
    class func dictionary(from beacon: CLBeacon?) -> [AnyHashable : Any]? {
        var proximity: String?
        switch beacon?.proximity {
            case .unknown:
                proximity = "unknown"
            case .immediate:
                proximity = "immediate"
            case .near:
                proximity = "near"
            case .far:
                proximity = "far"
            case .none:
                break
        @unknown default:
                break
        }

        let rssi = NSNumber(value: beacon?.rssi ?? 0)
        if let major = beacon?.major, let minor = beacon?.minor {
            return [
                "proximityUUID": beacon?.proximityUUID.uuidString ?? "",
                "major": major,
                "minor": minor,
                "rssi": rssi,
                "accuracy": String(format: "%.2f", beacon?.accuracy ?? 0),
                "proximity": proximity ?? ""
            ]
        }
        return nil
    }

    class func dictionary(from region: CLBeaconRegion?) -> [AnyHashable : Any]? {
        var major = region?.major
        if major == nil {
            major = NSNumber()
        }
        var minor = region?.minor
        if minor == nil {
            minor = NSNumber()
        }

        if let major = major, let minor = minor {
            return [
                "identifier": region?.identifier ?? "",
                "proximityUUID": region?.proximityUUID.uuidString ?? "",
                "major": major,
                "minor": minor
            ]
        }
        return nil
    }

    class func region(fromDictionary dict: [AnyHashable : Any]?) -> CLBeaconRegion? {
        let identifier = dict?["identifier"] as? String
        let proximityUUID = dict?["proximityUUID"] as? String
        let major = dict?["major"] as? NSNumber
        let minor = dict?["minor"] as? NSNumber

        var region: CLBeaconRegion? = nil
        if proximityUUID != nil && major != nil && minor != nil {
            if let uuid = UUID(uuidString: proximityUUID ?? "") {
                region = CLBeaconRegion(proximityUUID: uuid, major: CLBeaconMajorValue(major?.intValue ?? 0), minor: CLBeaconMinorValue(minor?.intValue ?? 0), identifier: identifier ?? "")
            }
        } else if proximityUUID != nil && major != nil {
            if let uuid = UUID(uuidString: proximityUUID ?? "") {
                region = CLBeaconRegion(proximityUUID: uuid, major: CLBeaconMajorValue(major?.intValue ?? 0), identifier: identifier ?? "")
            }
        } else if proximityUUID != nil {
            if let uuid = UUID(uuidString: proximityUUID ?? "") {
                region = CLBeaconRegion(proximityUUID: uuid, identifier: identifier ?? "")
            }
        }

        return region
    }
}
