//
//  Configuration.swift
//  al_push_plugin
//
//  Created by zeekrs on 2022/8/19.
//

import Foundation


extension String {
    func toResolution() -> AlivcLivePushResolution {
        switch self {
        case "resolution360P":
            return .resolution360P
        case "resolution480P":
            return .resolution480P
        case "resolution540P":
            return .resolution540P
        case "resolution720P":
            return .resolution720P
        case "resolution1080P":
            return .resolution1080P
        default:
            return .resolution720P
        }
    }
}
