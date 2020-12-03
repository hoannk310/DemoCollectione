//
//  ImageViewController.swift
//  DemoCollectione
//
//  Created by Apple on 9/5/1942 Saka.
//

import UIKit

class ImageViewController: UIViewController,UIScrollViewDelegate{
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var myImg: UIImageView!
    var img = UIImage()
    
    var imgArray = [UIImage]()
    var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        myImg.isUserInteractionEnabled = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        myImg.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        myImg.addGestureRecognizer(swipeLeft)
        myImg.image = imgArray[index]
        scroll.maximumZoomScale = 4
        scroll.minimumZoomScale = 1
        scroll.delegate = self
      
    }
    @objc func swipeGesture(sender:UISwipeGestureRecognizer?)
    {
        if  let swipeGes = sender {
            switch swipeGes.direction {
            case UISwipeGestureRecognizer.Direction.right:
                index = index - 1
                if index < 0 {
                    
                    index = imgArray.count - 1
                    myImg.image = imgArray[index]
                }else{
                    myImg.image = imgArray[index]
                }
                
                print("phải",  index)
            case UISwipeGestureRecognizer.Direction.left:
                index = index + 1
                if index == imgArray.count {
                    index = 0
                    myImg.image = imgArray[index]
                }else{
                    myImg.image = imgArray[index]
                }
              
                print("trái",  index)
            default:
                break
            }
        }
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myImg
    }
    
 
 
}
