//
//  File.swift
//  MedicalApp
//
//  Created by Денис Комиссаров on 04.07.2023.
//

import Foundation

public enum BluetoothStatus{
    case ConnectStart
    
    case ConnectFail
    
    case Connected
    
    case ConnectSuccess
    
    case ConnectDisconnect
    
    case NotCorrectPin
    
    case InvalidDeviceTemplate
}

public enum PlatformStatus{
    case Success
    
    case Failed
    
    case NoDataSend
    
    case DataCashed
}

public enum Atributes : String{
    case SerialNumber
    
    case BatteryLevel
    
    case TemperatureLevel
    
    case TimeStamp
    
    case Temperature
    
    case Glucose
    
    case Measurements
    
    case ModelNumber
    
    case Systolic
    
    case Diastolic
    
    case HeartRat
}
