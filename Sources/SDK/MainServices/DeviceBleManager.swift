import Foundation
import CoreBluetooth

internal class DeviceBleManager :
    DeviceScaningDelegate,
    DeviceConnectionDelegate,
    ServicesDiscoveryDelegate,
    ReadWirteCharteristicDelegate,
    ReadRSSIValueDelegate
{
    var manager:BLEManager = BLEManager.getSharedBLEManager()
    
    var scanedDevice: Set<ScanedDevice> = []
    
    init(){
        manager.initCentralManager(queue: DispatchQueue.main, options: nil)
        manager.scaningDelegate       = self    //DeviceScaningDelegat
        manager.connectionDelegate    = self    //DeviceConnectionDelegate
        manager.discoveryDelegate     = self    //ServicesDiscoveryDelegate
        manager.readWriteCharDelegate = self    //ReadWirteCharteristicDelegate
        manager.readRSSIdelegate      = self    //ReadRSSIValueDelegate
    }
    
    func scanDevices(){
        print("Start Scan")
        scanedDevice.removeAll()
        manager.scanAllDevices()
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) {
            timer in
            print("Stop Scan")
            self.manager.stopScan()
            timer.invalidate()
            print("postScannedDeivce Delegate")
            self.scanedDevice.forEach { dev in print(dev.deviceName) }
        }
    }
    
    func connectDevice(name: String){
        if let device: CBPeripheral = self.scanedDevice.first(where: { $0.deviceName.starts(with: name) })?.deviceObject {
            manager.connectPeripheralDevice(peripheral: device, options: nil)
        }
    }
    
    
    func dirrectConnect(){
        manager.centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    
    
    
    //ScanningDelegates:
    func scanningStatus(status: Int) {
            print(status)
    }
    
    func bleManagerDiscover(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        print("deviceDiscover")
        if let deviceName = peripheral.name {
            scanedDevice.insert(ScanedDevice(deviceName: deviceName, deviceObject: peripheral) )
        }
    }
    
    //ConnectionDelegates
    func bleManagerConnectionFail (_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(peripheral)
        print(error!)
    }
    
    func bleManagerDidConnect(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print(peripheral)
    }
    
    func bleManagerDisConect(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print(peripheral)
        print(error!)
    }
    
    //ServiceDiscoverDelegate
    func bleManagerDiscoverService (_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print(peripheral)
        print(error!)
    }
    
    func bleManagerDiscoverCharacteristics (_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?){
        print(peripheral)
        print(service)
        print(error!)
    }
    
    func bleManagerDiscoverDescriptors (_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?){
        print(peripheral)
        print(characteristic)
        print(error!)
    }
    
    func bleManagerDidUpdateValueForChar(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print(peripheral)
        print(characteristic)
        print(error!)
    }
    
    func bleManagerDidWriteValueForChar(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print(peripheral)
        print(characteristic)
        print(error!)
    }
    
    func bleManagerDidUpdateValueForDesc(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        print(peripheral)
        print(descriptor)
        print(error!)
    }
    
    func bleManagerDidWriteValueForDesc(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?){
        print(peripheral)
        print(descriptor)
        print(error!)
    }
    
    func bleManagerDidUpdateNotificationState(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print(peripheral)
        print(characteristic)
        print(error!)
    }
    
    func postBLEConnectionStatus(status:Int) {
        print(status)
    }
    
    func postScannedDevices(scannedDevices: NSArray){

    }
    
    func bleManagerReadRSSIValue(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print(peripheral)
        print(RSSI)
        print(error!)
    }
    
    struct ScanedDevice: Hashable{
        var deviceName: String
        var deviceObject: CBPeripheral
    }
    
}




