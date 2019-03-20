//
//  ViewController.swift
//  SO Question: TableVCell with varying height
//
//  Created by BugDev Studios on 20/03/2019.
//  Copyright © 2019 BugDev Studios. All rights reserved.
//

import UIKit
import Kingfisher

struct CellItem {
  let title: String
  let subTitle: String
  let imageUrlStr : String
  
  var image : UIImage?
  
  init(title: String, subTitle: String, imageUrlStr: String) {
    self.title = title
    self.subTitle = subTitle
    self.imageUrlStr = imageUrlStr
    self.image = nil
    
  }
}

struct images {
  static let square150 = UIImage.init(named: "150")
  static let port200Cross100 = UIImage.init(named: "200x100")
}

struct strings {
  
  static let loremEpsumStr1 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
  static let loremEpsumStr2 = "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"
  static let loremEpsumStr3 = "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged"
  static let loremEpsumStr4 = "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
  
}
class ViewController: UITableViewController {

  var arrayListItems = [CellItem]()
  let baseUrlStr = "https://via.placeholder.com/"
  let cellIdentifierTitle = "TableViewCellTitle"
  let cellIdentifierSubTitle = "TableViewCellSubTitle"
  let cellIdentifierImage  = "TableViewCellImage"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fillArrayWithData()
    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableView.automaticDimension
    tableView.reloadData()
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func fillArrayWithData(){
    
    
    
    var item = CellItem.init(title: "50 x 50", subTitle: strings.loremEpsumStr1, imageUrlStr: baseUrlStr + "50")
    arrayListItems.append(item)
    
    item = CellItem.init(title: "100 x 50", subTitle: strings.loremEpsumStr2, imageUrlStr: baseUrlStr + "100X50")
    arrayListItems.append(item)
    
    item = CellItem.init(title: "50 x 100", subTitle: strings.loremEpsumStr3, imageUrlStr: baseUrlStr + "50X100")
    arrayListItems.append(item)
    
    item = CellItem.init(title: "150 x 150", subTitle: strings.loremEpsumStr4, imageUrlStr: baseUrlStr + "150")
    arrayListItems.append(item)
    
    item = CellItem.init(title: "150 x 300", subTitle: strings.loremEpsumStr1, imageUrlStr: baseUrlStr + "150X300")
    arrayListItems.append(item)
    
    
    
    
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return arrayListItems.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.row {
    case 0:
      let cellTitle = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTitle) as! TableViewCell
      let strThisImageIs = "This Image is "
      cellTitle.lblTitle.text = strThisImageIs + arrayListItems[indexPath.section].title
      cellTitle.lblTitle.font = UIFont.boldSystemFont(ofSize: 17)
      return cellTitle
      
    case 1:
      
      let cellSubTitle = tableView.dequeueReusableCell(withIdentifier: cellIdentifierSubTitle) as! TableViewCell
      cellSubTitle.lblSubtitle.text = arrayListItems[indexPath.section].subTitle
      return cellSubTitle
      
    case 2:
      
      let cellImage = tableView.dequeueReusableCell(withIdentifier: cellIdentifierImage) as! TableViewCell
      let item = arrayListItems[indexPath.section]
      //if we already have the image, just show
      if let image = arrayListItems[indexPath.section].image {
        cellImage.imageViewPicture.image = image
      }else {
        
        if let url = URL.init(string: item.imageUrlStr) {
          
          cellImage.imageViewPicture.kf.setImage(with: url) { [weak self] result in
            guard let strongSelf = self else { return } //arc
            // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
            switch result {
            case .success(let value):
              // The image was set to image view:
              
              print("=====Image Size \(value.image.size)"  )
              strongSelf.arrayListItems[indexPath.section].image = value.image
              DispatchQueue.main.async {
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
              }
              // From where the image was retrieved:
              // - .none - Just downloaded.
              // - .memory - Got from memory cache.
              // - .disk - Got from disk cache.
              print(value.cacheType)
              
              // The source object which contains information like `url`.
              print(value.source)
              
            case .failure(let error):
              print(error) // The error happens
            }
          }
          
        }
        
      }
      
      
      return cellImage
      
    default:
      print("this should not be called")
    }
  
    //this should not be executed
    return .init()
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    
    switch indexPath.row {
    case 0, 1:
      return 30
    case 2:
      return 170
    default:
      print("default called.")
    }
    return 200
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //calculate the height of label cells automatically in each section
    if indexPath.row == 0 || indexPath.row == 1 { return UITableView.automaticDimension }
    
    // calculating the height of image programatically.
    else if indexPath.row == 2, let image = arrayListItems[indexPath.section].image {
      
      print("heightForRowAt indexPath : \(indexPath)")
      //image
      
      let imageWidth = image.size.width
      let imageHeight = image.size.height
      
      guard imageWidth > 0 && imageHeight > 0 else { return UITableView.automaticDimension }
//      let Imageratio = imageWidth / imageWidth
      
      //images always be the full width of the screen
      let requiredWidth = tableView.frame.width
      
      let widthRatio = requiredWidth / imageWidth
      
      let requiredHeight = imageHeight * widthRatio
//      let newSize = CGSize.init(width: requiredWidth, height: requiredHeight)
      print("returned height \(requiredHeight) at indexPath: \(indexPath)")
      return requiredHeight
      
      
    }
    else { return UITableView.automaticDimension }
  }
  
}

