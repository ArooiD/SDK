//
//  File.swift
//  MedicalApp
//
//  Created by Денис Комиссаров on 04.07.2023.
//

import Foundation

///Статусы при работе с перефирийными устройствами
public enum BluetoothStatus{
    case ConnectStart
    
    case ConnectFail
    
    case Connected
    
    case ConnectSuccess
    
    case ConnectDisconnect
    
    case NotCorrectPin
    
    case InvalidDeviceTemplate
}

///Статусы при отправке данных на платформу
public enum PlatformStatus{
    case Success
    
    case Failed
    
    case NoDataSend
    
    case DataCashed
}

///Атрибуты при собираемых данных
public enum Atributes : String{
    ///Серийный номер устройства, объект String
    case SerialNumber
    ///Уровень батареи, объект Integer
    case BatteryLevel
    ///Температура в кельвинах, объект Integer
    case TemperatureLevel
    ///Время когда было сделано измерения, объект Date
    case TimeStamp
    
    case Temperature
    ///Показатель глюкозы в крови
    case Glucose
    ///Объект измерений
    case Measurements
    ///Модель устройства, объект String
    case ModelNumber
    
    //case Systolic
    
    //case Diastolic
    
    //case HeartRat
}
