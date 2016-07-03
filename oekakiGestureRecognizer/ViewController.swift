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
            let imageAfterDraw = drawCircle(self.imageView.image, size: size, center: touchPoint)
            self.imageView.image = imageAfterDraw
            
        default:
            break
            
        }
    
    }
    
    func drawCircle(canvas: UIImage?, size: CGSize, center: CGPoint) -> UIImage {
        
        let radius: CGFloat = 20.0                                          //Drawする円の半径
        let red: CGFloat = 1.0                                              //Drawする色 R
        let blue: CGFloat = 0.0                                             //Drawする色 B
        let green: CGFloat = 0.0                                            //Drawする色 G
        let alpha: CGFloat = 1.0                                            //Drawする色 Alpha
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)            //コンテキストを取得
        
        //タップした時に描く円のRect
        let circleRect = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2)
        

        canvas?.drawInRect(CGRectMake(0, 0, size.width, size.height))        //コンテキストにimageViewの内容を写す
        let circlePath = UIBezierPath(ovalInRect: circleRect)               //円を描く
        let color = UIColor(red:red, green:green, blue:blue, alpha:alpha)   //透明色を格納
        color.setFill()
        circlePath.fill()
        let retImage = UIGraphicsGetImageFromCurrentImageContext()          //UIImageを取得する
        UIGraphicsEndImageContext()                                         //コンテキストを閉じる
        
        return retImage                                                     //UIImageをReturnする
        
    }


}

