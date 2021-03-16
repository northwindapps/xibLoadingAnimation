//
//  LoginViewController.swift
//  socialapp
//
//  Created by yujin on 2021/03/13.
//

import UIKit
let HOST_IP = "northwindapps.com"
let session = URLSession.shared

class LoginViewController: ViewController {

    var loadingview1:loadingview!
    var timerCounter = 0
  
    
    @IBOutlet weak var resultview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let timer_loading = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
        
        fetchquestion(token: "notoken"){
            data in
            timer_loading.invalidate()
            if self.loadingview1 != nil{
                self.loadingview1.removeFromSuperview()
            }
            
            self.resultview.text = "Done"
            print(data)
            
        }
    }
    

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */
    
    func openloadingview(){
        
        if loadingview1 != nil{
            loadingview1.removeFromSuperview()
        }
        
        loadingview1 = loadingview(frame:CGRect(x:0,y:(self.view.frame.height/2) - 150,width:self.view.frame.width,height:300))
        switch timerCounter%3 {
        
       
        case 0:
         
            loadingview1.imageview.image = UIImage(named:"counter1")
//            loadingview1.imageview.contentMode = .scaleAspectFit
            break
        case 1:
         
            loadingview1.imageview.image = UIImage(named:"counter2")
//            loadingview1.imageview.contentMode = .scaleAspectFit
            break
        case 2:
           
            loadingview1.imageview.image = UIImage(named:"counter3")
//            loadingview1.imageview.contentMode = .scaleAspectFit
            break
        default:
            break
        }
        
        self.view.addSubview(loadingview1)
        
        
    }
    
    @objc func timerUpdate(){
        timerCounter += 1
        openloadingview()
    }
    
    //https://stackoverflow.com/questions/25203556/returning-data-from-async-call-in-swift-function
    
    //https://medium.com/@dhavalkansara51/completion-handler-in-swift-with-escaping-and-nonescaping-closures-1ea717dc93a4
    
    func fetchquestion(token:String,completion: @escaping (NSArray)-> Void){
           
           let Url = "https://" + HOST_IP + "/api/post"
                   print(Url)
                 let serviceUrl = URL(string: Url)
                 var request = URLRequest(url: serviceUrl!)
                 request.setValue("Bearer " + token, forHTTPHeaderField:  "Authorization" )
                 request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                 request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
                 
                 request.httpMethod = "GET"
                
           
        session.dataTask(with: request as URLRequest, completionHandler:{ (data, response, error) in
                
                     if let data = data {
                         do {
                           let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]

                            var output = NSMutableArray()
                            let check = json["data"] as? NSArray
                            
                            if check != nil{
                                for i in 0..<check!.count {
                                    output.add(check![i])
                                }
                            }
                            
                            
                            DispatchQueue.main.async{
                                completion(output)
                            }
                            
                            
                         } catch {
                           print(error)
    
                         }
                     }
                     }).resume()
       }
    
    

}
