//
//  KeyboardViewController.swift
//  VikashDemoKeys
//
//  Created by Vikash Kumar on 20/09/17.
//  Copyright © 2017 Vikash Kumar. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var collView: UICollectionView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    
    var customInterface: UIView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        let nib = UINib(nibName: "VikashDemoKeys", bundle: Bundle(for: KeyboardViewController.self))
        
        let objects = nib.instantiate(withOwner: self, options: nil)
        customInterface = objects[0] as! UIView
        print(customInterface)
        
        collView.register(CollCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var images = [UIImage]()
    override func viewDidLoad() {
        //super.viewDidLoad()
        customInterface.frame = self.view.bounds
        self.view.addSubview(customInterface)
        
         images = (1..<37).map({num in
            return UIImage(named: "\(num).jpg")!
        })

    }
    
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
//        var textColor: UIColor
//        let proxy = self.textDocumentProxy
//        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
//            textColor = UIColor.white
//        } else {
//            textColor = UIColor.black
//        }
        //self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }


}

//MARK: CollectionView DataSource and Delegate
extension KeyboardViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollCell
        cell.imgView.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        let imageData = UIImagePNGRepresentation(image)
        let pasteBoard = UIPasteboard.general
        pasteBoard.setData(imageData!, forPasteboardType: UIPasteboardTypeListImage.object(at: 0) as! String)
    }
}


class CollCell: UICollectionViewCell {
    @IBOutlet var imgView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView = UIImageView()
        imgView.frame = self.bounds
        self.addSubview(imgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
