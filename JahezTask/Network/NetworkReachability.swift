//
//  NetworkReachability.swift
//  JahezTask
//
//  Created by Eslam Salem on 03/01/2024.
//

import Foundation
import Reachability

class NetworkReachability {
    static var isOnline: Bool {
        var result = true
        do {
            result = try Reachability().connection != .unavailable
        } catch {
            print("An error occurred: \(error)")
        }
        return result
    }
}
