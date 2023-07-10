import Foundation


private var sharedManager: InternetManager? = nil

fileprivate class _baseCallback: DeviceCallback {
    func onExploreDevice(mac: UUID, atr: Atributes, value: Any){}
    
    func onStatusDevice(mac: UUID, status: BluetoothStatus){ }
    
    func onSendData(mac: UUID, status: PlatformStatus){ }
    
    func onExpection(mac: UUID, ex: Error){ }
    
    func onDisconnect(mac: UUID, data: ([Atributes: Any], Array<Measurements>)){}
    
    func findDevice(peripheral: DisplayPeripheral){}
    
    func searchedDevices(peripherals: [DisplayPeripheral]){}
}


class InternetManager{
    internal var baseAddress: String
    internal var apiAddress: String
    //Url's variabls
    internal var urlGateWay: URL
    //Encoded login/password
    internal var auth: String
    internal var sdkVersion: String?
    
    internal var callback: DeviceCallback
    
    static internal func getManager () -> InternetManager {
        if sharedManager == nil {
            sharedManager = InternetManager(login: "", password: "", debug: true, callback: _baseCallback())
        }
        return sharedManager!
    }
    
    internal init(login: String, password: String, debug: Bool, callback: DeviceCallback) {
        let encData: Data = (login + password).data(using: .utf8)!
        self.auth = "Basic ".appending(encData.base64EncodedString())
        apiAddress = "/gateway/iiot/api/Observation/data"
        if(!debug){ baseAddress = "https://ppma.ru" }
        else{ baseAddress = "http://test.ppma.ru" }
        self.urlGateWay = URL(string: (self.baseAddress + self.apiAddress))!
        self.callback = callback
        self.sdkVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        sharedManager = self
    }
    
    internal func postResource(identifier: UUID, data: Data) {
        var urlRequest: URLRequest = URLRequest(url: self.urlGateWay)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Authorization", forHTTPHeaderField: self.auth)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //urlRequest
        urlRequest.httpBody = data
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                self.callback.onExpection(mac: identifier, ex: error)
                print("Error: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if(statusCode <= 202){
                    print("Status Code: \(statusCode)")
                    self.callback.onSendData(mac: identifier, status: PlatformStatus.Success)
                }
                else{
                    self.callback.onSendData(mac: identifier, status: PlatformStatus.Failed)
                }
            }
            if let responseData = data {
                if let responseString = String(data: responseData, encoding: .utf8) {
                    print("Response: \(responseString)")
                }
            }
        }
        task.resume()
    }
    
    internal func getTime(serial: String){
        let timeUrl  = URL(string: (self.baseAddress + self.apiAddress + "?serial=\(serial)&type=effectiveDateTime"))!
        var urlRequest: URLRequest = URLRequest(url: timeUrl)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("Authorization", forHTTPHeaderField: self.auth)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("Status Code: \(statusCode)")
            }
            if let responseData = data {
                if let responseString = String(data: responseData, encoding: .utf8) {
                    let time = EltaGlucometr.FormatPlatformTime.date(from: responseString)
                    EltaGlucometr.lastDateMeasurements = time
                }
            }
        }
        task.resume()
    }
}


