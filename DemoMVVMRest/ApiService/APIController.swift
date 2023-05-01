
import Foundation

class APIController {
    
    static let shared = APIController()
    fileprivate var userToken: String?
    
}

protocol APIControllerProtocol {
    func postAPI(apiUrl : String, requestParams: [String: AnyObject], completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ())
    func getAPI(apiUrl : String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ())
    func requestDeleteMethod(apiUrl : String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ())
    
}

class UserService: APIControllerProtocol {
    
    let constValueField = "application/json; charset=UTF-8"
    let constHeaderField = "Content-Type"
    func getAPI(apiUrl : String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                completion(false, "str" as AnyObject)
                return
            }
            do {
                if (try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary) != nil {
                    print("convertedJsonIntoDict")
                }
                completion(true,data as AnyObject)
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(false, nil)
            }
        }).resume()
        
    }
    
    func postAPI(apiUrl : String, requestParams: [String: AnyObject], completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = "POST"
        request.setValue(constValueField, forHTTPHeaderField: constHeaderField)
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: requestParams, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                completion(false, "str" as AnyObject)
                return
            }
            do {
                if (try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary) != nil {
                    print("convertedJsonIntoDict")
                }
                completion(true,data as AnyObject)
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(false, nil)
            }
        }).resume()    }
    
    func requestDeleteMethod(apiUrl : String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        
        request.httpMethod = "DELETE"
        request.addValue(constValueField, forHTTPHeaderField: constHeaderField)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if error != nil{
                return
            }
            
            _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
                {
                    completion(true, convertedJsonIntoDict)
                }
                else{
                    completion(false, nil)
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
    
    func requestPUTMethod(apiUrl : String, params: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = "PUT"
        request.httpBody = params.data(using: String.Encoding.utf8);
        let sessionConfig = URLSession(configuration: URLSessionConfiguration.default)
        
        let task: URLSessionDataTask = sessionConfig.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                let str = AlertMessage.msgNotReachable
                completion(false, str as AnyObject)
                return
            }
            do {
                if (try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary) != nil {
                    print("convertedJsonIntoDict")
                }
                completion(true,data as AnyObject)
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(false, nil)
            }
        })
        task.resume()
    }
}
