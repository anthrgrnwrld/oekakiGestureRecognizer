//
//  ViewController.swift
//  oekakiGestureRecognizer
//
//  Created by Masaki Horimoto on 2016/06/28.
//  Copyright © 2016年 Masaki Horimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myOekaki = OekakiGestureRecognizer(target: self, action: #selector(ViewController.drawGesture(_:)))
        self.view.addGestureRecognizer(myOekaki)
        
        
        let size = self.imageView.frame.size                                //コンテキストのサイズ
        
        //(extension対策)self.imageView.imageに所期画像を追加しておく
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.imageView.image?.drawInRect(CGRectMake(0, 0, size.width, size.height))
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    internal func drawGesture(sender: AnyObject) {
        
        guard let oekakiGesture = sender as? OekakiGestureRecognizer else {
            print("Oekaki Gesture Error happened.")
            return
        }
        
        switch oekakiGesture.state {
            
        case .Began:
            
            let size = self.imageView.frame.size                                //コンテキストのサイズ
            let touchPoint = oekakiGesture.locationInView(self.imageView)       //タッチ座標を取得
            
            //Drawを実行 -> 結果をUIImageにて取得
            //let imageAfterDraw = drawCircle(self.imageView.image, size: size, center: touchPoint)
            let imageAfterDraw = self.imageView.image?.drawCircle(size, center: touchPoint)
            self.imageView.image = imageAfterDraw
            
        default:
            break
            
        }
        
    }



}

