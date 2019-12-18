//
//  CoverViewController.swift
//  codingassign2
//
//  Created by Igwe Onumah on 12/17/19.
//  Copyright © 2019 Igwe Onumah. All rights reserved.
//
import Foundation
import UIKit

class CoverViewController: UIViewController {

    
    @IBOutlet weak var coverView: UIImageView!
    
    var cover: Cover! //implicit unwrap - this value will be there when called
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupCover()
            
    }
  
 
    private func setupCover()
    {
        guard let myCover = cover else {return}

            guard let url = URL(string: myCover.img) else {return}
            var data = Data()
            
            do{
                data = try Data(contentsOf: url)
                
                
            }catch{
                print("Error with image: " + error.localizedDescription)
            }

            
            guard let image = UIImage(data: data) else {return }
            
           
        coverView.image = image
      
    }

}
