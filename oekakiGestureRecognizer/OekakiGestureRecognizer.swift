//
//  OekakiGestureRecognizer.swift
//  oekakiGestureRecognizer
//
//  Created by Masaki Horimoto on 2016/06/28.
//  Copyright © 2016年 Masaki Horimoto. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class OekakiGestureRecognizer: UIGestureRecognizer
{
    
    var touchPoint: CGPoint?                                //タッチ座標を格納
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent)
    {
        
        let numberOfTouches = event.allTouches()!.count     //タッチした指の本数を取得
        
        if numberOfTouches != 1 {
            self.state = .Cancelled                         //タッチ本数が1本以外の場合はstateをCancelに
        }
        
        if self.state == .Possible {
            let touch = touches.first! as UITouch
            touchPoint = touch.locationInView(self.view)    //タッチ座標を取得・格納
            self.state = .Began                             //stateをBeganに
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        let touch = touches.first! as UITouch
        touchPoint = touch.locationInView(self.view)        //タッチ座標を取得・格納
        self.state = .Changed                               //stateをChangedに
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        let touch = touches.first! as UITouch
        touchPoint = touch.locationInView(self.view)        //タッチ座標を取得・格納
        self.state = .Ended                                 //stateをEndedに
    }
    
    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        let touch = touches.first! as UITouch
        touchPoint = touch.locationInView(self.view)        //タッチ座標を取得・格納
        self.state  = .Cancelled                            //stateをCancelledに
    }
    
    override func locationInView(view: UIView?) -> CGPoint {
        
        guard var tchpnt = touchPoint else {
            fatalError("Can't get touchPoint")
        }
        
        //parameterのviewがUIScrollViewか否かで処理を分岐(拡大時対応の為)
        if let parameterView = self.view! as? UIScrollView {
            
            let contentSize = parameterView.contentSize
            let rate = self.view!.bounds.width / contentSize.width
            
            tchpnt.x = tchpnt.x * rate
            tchpnt.y = tchpnt.y * rate
            
            return tchpnt                                   //parameterのviewがUIScrollViewだった時
            
        } else {
            return tchpnt                                   //parameterのviewがUIScrollView以外だった時
        }
        
        
    }
    
    
}
