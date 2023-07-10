//
//  BaseConnectClass.swift
//  MedicalApp
//
//  Created by Денис Комиссаров on 04.07.2023.
//

import Foundation
import CoreBluetooth

public class ConnectClass{
    public static var activeExecute: Bool = false
    
    internal var cred: String?
    
    internal var callback: DeviceCallback?
    
    internal var bleManager: BLEManager?
    
    init() {
        bleManager = BLEManager.getSharedBLEManager()
    }
    
    init(cred: String) {
        self.cred = cred
    }
    
    init(outCallback: DeviceCallback){
        callback = outCallback
    }
    
    init(outCallback: DeviceCallback, cred: String){
        callback = outCallback
        self.cred = cred
    }
    
    public func connect(device: CBPeripheral){ }
    
    public func search(timeout: UInt32){ }
    
    
    
}

