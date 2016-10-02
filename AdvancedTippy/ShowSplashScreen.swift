//
//  ShowSplashScreen.swift
//  AdvancedTippy
//
//  Created by Jose Villanuva on 9/27/16.
//  Copyright © 2016 Jose Villanuva. All rights reserved.
//

import UIKit

class ShowSplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        addBackgroundImage()
        //addLogo()
        
        _ = Timer.scheduledTimer(
            timeInterval: 2.5, target: self, selector: #selector(UIAlertView.show), userInfo: nil, repeats: false
        )
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func show() {
        self.performSegue(withIdentifier: "showApp", sender: self)
    }
    
    func addBackgroundImage() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let bg = UIImage(named: "splashImage.png")
        let bgView = UIImageView(image: bg)
        
        bgView.frame = CGRect(x:(screenSize.width/2) - 50, y:(screenSize.height/2), width: 100, height: 100)
        //let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.view.addSubview(bgView)
    }
    
//    func addLogo() {
//        let screenSize: CGRect = UIScreen.main.bounds
//        
//        let logo     = UIImage(named: "iconLogo.png")
//        let logoView = UIImageView(image: logo)
//        
//        let w = logo?.size.width
//        let h = logo?.size.height
//        
//        //logoView.frame = CGRectMake( (screenSize.width/2) - (w!/2), 5, w!, h! )
//        logoView.frame = CGRectMake((screenSize.width/2) - (w!/2), 5, w!, h! )
//        self.view.addSubview(logoView)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
