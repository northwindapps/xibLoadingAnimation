//
//  loadingview.swift
//  socialapp
//
//  Created by yujin on 2021/03/13.
//

import UIKit

class loadingview: UIView {

    var view:UIView!

    @IBOutlet weak var imageview: UIImageView!
    override init(frame:CGRect){

        super.init(frame:frame)

        setup()
    }

    required init(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)!
        setup()
    }

    func setup(){
        view = loadviewfromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }

    func loadviewfromNib()->UIView{
        let bundle = Bundle(for:type(of:self))
        let nib = UINib(nibName:"LoadingView",bundle:bundle)
        let view = nib.instantiate(withOwner:self,options:nil)[0] as! UIView
        return view
    }

}
