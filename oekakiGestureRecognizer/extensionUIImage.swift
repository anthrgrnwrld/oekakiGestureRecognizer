//
//  extensionUIImage.swift
//  oekakiGestureRecognizer
//
//  Created by Masaki Horimoto on 2016/07/04.
//  Copyright © 2016年 Masaki Horimoto. All rights reserved.
//

import UIKit

extension UIImage {
    
    func drawCircle(size: CGSize, center: CGPoint) -> UIImage {
        
        let radius: CGFloat = 20.0                                          //Drawする円の半径
        let red: CGFloat = 1.0                                              //Drawする色 R
        let blue: CGFloat = 0.0                                             //Drawする色 B
        let green: CGFloat = 0.0                                            //Drawする色 G
        let alpha: CGFloat = 1.0                                            //Drawする色 Alpha
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)            //コンテキストを取得
        
        //タップした時に描く円のRect
        let circleRect = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2)
        
        
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))          //コンテキストにimageViewの内容を写す
        let circlePath = UIBezierPath(ovalInRect: circleRect)               //円を描く
        let color = UIColor(red:red, green:green, blue:blue, alpha:alpha)   //透明色を格納
        color.setFill()
        circlePath.fill()
        let retImage = UIGraphicsGetImageFromCurrentImageContext()          //UIImageを取得する
        UIGraphicsEndImageContext()                                         //コンテキストを閉じる
        
        return retImage                                                     //UIImageをReturnする
        
    }
    
}

