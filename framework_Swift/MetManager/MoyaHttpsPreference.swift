//
//  MoyaHttpsPreference.swift
//  smart_Swift
//
//  Created by Origin on 2018/3/9.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation
import Moya
import Alamofire

public extension Moya.Manager {
    
    public static func https() -> Moya.Manager {
        
        let path = Bundle.main.path(forResource: "https", ofType: "cer")
        
        guard path?.isEmpty == false else {
            return SessionManager.default
        }
        
        var policies: [String: ServerTrustPolicy] = [String: ServerTrustPolicy]()
        do {
            let data = try Data(contentsOf: URL(string: path!)!)
            let certification: [SecCertificate] = [data as! SecCertificate]
            policies = ["172.16.88.230": .pinCertificates(certificates: certification, validateCertificateChain: true, validateHost: true)]
        } catch {
            return SessionManager.default
        }
        
        return SessionManager(serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
        
    }
    
}
