//
//  FlowDelegate.swift.swift
//  ondato_skd
//
//  Created by Jhionan Rian Lara dos Santos on 01/12/21.
//

import Foundation
import Flutter
import OndatoSDK



class FlowDelegate : OndatoSDK.OndatoFlowDelegate {
    private let result : FlutterResult
    func flowDidSucceed(identificationId: String?) {
        result(["identificationId": identificationId])
    }
    
    func flowDidFail(identificationId: String?, error: OndatoServiceError) {
        result(["identificationId": identificationId, "error": error.message])
    }
    
    
    init(flutterResult: @escaping FlutterResult) {
        self.result = flutterResult
    }
    
    func setDelegate() -> OndatoFlowDelegate? {
        return self;
    }
    
}
