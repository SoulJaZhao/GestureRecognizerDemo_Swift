//
//  ViewController.swift
//  GestureRecognizerDemo
//
//  Created by SoulJa on 2017/6/10.
//  Copyright © 2017年 com.soulja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //图片
    @IBOutlet weak var imageView: UIImageView!
    //图片索引
    var currentIndex:Int = 0
    //图片数量
    let imageCount:Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化设置
        let image = UIImage.init(named: "\(currentIndex)")
        
        imageView.image = image
        
        imageView.isUserInteractionEnabled = true
        
        //添加手势操作
        self.addGestureRecognizer()
        
        //展示标题
        self.showTitle()
    }
    
    //MARK:添加手势操作
    func addGestureRecognizer() {
        /*添加点按手势*/
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImage(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGesture)
        
        /*添加长按手势*/
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressImage(recognizer:)))
        longPressGesture.minimumPressDuration = 1
        imageView.addGestureRecognizer(longPressGesture)
        
        /*添加捏合手势*/
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchImage(recognizer:)))
        view.addGestureRecognizer(pinchGesture)
        
        /*添加旋转手势*/
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateImage(recognizer:)))
        view.addGestureRecognizer(rotateGesture)
        
        /*添加拖动手势*/
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panImage(recognizer:)))
        imageView.addGestureRecognizer(panGesture)
        
        /*添加轻扫手势*/
        let swipeGestureToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeImage(recognizer:)))
        swipeGestureToRight.direction = .right
        imageView.addGestureRecognizer(swipeGestureToRight)
        
        let swipeGestureToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeImage(recognizer:)))
        swipeGestureToRight.direction = .left
        imageView.addGestureRecognizer(swipeGestureToLeft)
        
        //依赖关系
        panGesture.require(toFail: swipeGestureToRight)
        panGesture.require(toFail: swipeGestureToLeft)

        longPressGesture.require(toFail: panGesture)
    }
    
    //MARK:显示标题
    func showTitle() {
        switch currentIndex {
        case 0:
            self.title = "我老婆好美"
        case 1:
            self.title = "我老婆最爱我"
        case 2:
            self.title = "我最爱我老婆"
        default:
            break
        }
    }
    
    //MARK:点击图片
    func tapImage(recognizer:UITapGestureRecognizer) {
        let navHide = self.navigationController?.navigationBar.isHidden
        if navHide == true {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    //MARK:长按图片
    func longPressImage(recognizer:UILongPressGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.began {
            let alertView = UIAlertView(title: "老婆最美", message: "老婆最美", delegate: self, cancelButtonTitle: "确定")
            alertView.show()
        }
    }
    
    //MARK:捏合图片
    func pinchImage(recognizer:UIPinchGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.began {
            imageView.transform = CGAffineTransform(scaleX: recognizer.scale, y: recognizer.scale)
        } else {
            UIView.animate(withDuration: 2.0, animations: { 
                self.imageView.transform = CGAffineTransform.identity
            })
        }
    }
    
    //MARK:旋转图片
    func rotateImage(recognizer:UIRotationGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.changed {
            imageView.transform = CGAffineTransform(rotationAngle: recognizer.rotation)
        } else if recognizer.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 2.0, animations: {
                self.imageView.transform = CGAffineTransform.identity
            })
        }
    }
    
    //MARK:拖动图片
    func panImage(recognizer:UIPanGestureRecognizer) {
        if  recognizer.state == UIGestureRecognizerState.changed {
            let translation:CGPoint = recognizer.translation(in: view)
            imageView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        } else if recognizer.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 2.0, animations: {
                self.imageView.transform = CGAffineTransform.identity
            })
        }
    }
    
    //MARK:轻扫图片
    func swipeImage(recognizer:UISwipeGestureRecognizer) {
        if recognizer.direction == .right {
            let index:Int = (currentIndex + imageCount + 1)%imageCount
            imageView.image = UIImage.init(named: "\(index)")
            currentIndex = index
            self.showTitle()
        } else {
            let index:Int = (currentIndex + imageCount - 1)%imageCount
            imageView.image = UIImage.init(named: "\(index)")
            currentIndex = index
            self.showTitle()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

