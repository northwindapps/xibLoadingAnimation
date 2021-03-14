//
//  LoginViewController.swift
//  socialapp
//
//  Created by yujin on 2021/03/13.
//

import UIKit

class LoginViewController: UIViewController {

    var loadingview1:loadingview!
    var timerCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()


        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
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
            loadingview1.imageview.contentMode = .scaleAspectFit
            break
        case 1:
         
            loadingview1.imageview.image = UIImage(named:"counter2")
            loadingview1.imageview.contentMode = .scaleAspectFit
            break
        case 2:
           
            loadingview1.imageview.image = UIImage(named:"counter3")
            loadingview1.imageview.contentMode = .scaleAspectFit
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

}
