//
//  ViewController.swift
//  DemoCollectione
//
//  Created by Apple on 9/4/1942 Saka.
//

import UIKit
import Photos
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var images = [UIImage]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
      
        
        cell.myLabel.text = "\(indexPath.row + 1)"
        cell.myImage.image = images[indexPath.item]
        //cell.contentView.layer.cornerRadius = 10
        cell.contentView.backgroundColor = UIColor.white
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }

    @IBOutlet weak var coll: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coll.delegate = self
        coll.dataSource  = self
        getPhoto()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imgController = storyboard?.instantiateViewController(identifier: "ImageViewController") as? ImageViewController
        
        imgController?.img = images[indexPath.item]
        imgController?.imgArray = images
        imgController?.index = indexPath.row
        navigationController?.pushViewController(imgController!, animated: true)
    }
   
    
    
    func getPhoto(){
        let imgManager = PHImageManager.default()
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        if let fetchResult:PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions){
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count{
                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width: 110, height: 114), contentMode: .aspectFill, options: requestOption, resultHandler: {(image, error ) in
                        self.images.append(image!)
                        
                    })
                }
            }
        
        }
    }
    
}

