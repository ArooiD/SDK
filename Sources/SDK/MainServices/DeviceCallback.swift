//
//  DeviceCallback.swift
//  MedicalApp
//
//  Created by Денис Комиссаров on 06.06.2023.
//

import Foundation

public protocol DeviceCallback: AnyObject {
    func onExploreDevice(mac: UUID, atr: Atributes, value: Any);
    
    func onStatusDevice(mac: UUID, status: BluetoothStatus);
    
    func onSendData(mac: UUID, status: PlatformStatus);
    
    func onExpection(mac: UUID, ex: Error);
    
    func onDisconnect(mac: UUID, data: ([Atributes: Any], Array<Measurements>));
    
    func findDevice(peripheral: DisplayPeripheral);
    
    func searchedDevices(peripherals: [DisplayPeripheral]);
}



