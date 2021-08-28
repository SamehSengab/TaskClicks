import Foundation
import UIKit
import Alamofire

class ApiServices : UIViewController {
    var lang : String = "ar"
    static let instance = ApiServices()
    
    func getPosts<T : Decodable>(methodType: HTTPMethod = .post , parameters: [String: AnyObject]? = nil , url : String , Completion : @escaping (T? ,String?)->Void){
        
        let net = NetworkReachabilityManager()
        net?.startListening()
        net?.listener =
            { status in
                if  net?.isReachable ?? false
            {
                    let s = url
                    let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
                    let encodedURL = NSURL(string: encodedLink!)! as URL
                    
                    Alamofire.request(encodedURL, method: methodType, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
                        // print(urlString , methodType , parameters)
                        debugPrint(response)
                        if response.result.isSuccess {
                            let dict = response.result.value! as! [String: Any]
                            print(dict)
                            if dict["status"] as? String == "ok" {
                                print(response.data)
                                guard let data = response.data else {
                                    return
                                }
                                do {
                                    
                                    let Posts = try JSONDecoder().decode(T.self, from: data)
                                    
                                    Completion(Posts, nil)
                                }catch let error {
                                    
                                    Completion(nil , error.localizedDescription)
                                    print("----------->>>>>>>>>>>>>>>" ,error , "----------->>>>>>>>>>>>>>>>>>")
                                }
                                
                            }else{
                                if let code = dict["code"] as? Int {
                                    
                                    if code == 401 {
                                        //                                        AuthService.userData = nil
                                        //                                        Helper.restartApp("LoginVC")
                                        return
                                    }
                                    
                                }
                                
                                if let dictError = dict["msg"] as? String {
                                    Completion(nil , dictError)
                                }else {
                                    
                                    guard let errorStr = dict["msg"] as? String else {
                                        let errorsDict = dict["msg"] as! [String: Any]
                                        let errorsArr = errorsDict.values.first as! [String]
                                        
                                        Completion(nil , errorsArr[0])
                                        return
                                    }
                                    
                                    let msg = errorStr
                                    Completion(nil , msg as? String)
                                }
                            }
                            
                        } else { //FAILURE
                            
                            
                            Completion(nil,"anError")
                        }}
                }
                else
                {
                    Completion(nil,"noNet")
                    
                    //                    let message = MDCSnackbarMessage()
                    //                    message.text = "netWork error".localized
                    //
                    //                    MDCSnackbarManager.default.show(message)
                    // self.showStatus(image:#imageLiteral(resourceName: "wifi-no-symbol-your-design-600w-1697485225"), message: "No internet")
                    
                }
            }
    }
}
