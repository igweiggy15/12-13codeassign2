//
//  ViewController + Extension.swift
//  codingassign2
//
//  Created by Igwe Onumah on 12/17/19.
//  Copyright © 2019 Igwe Onumah. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController

{
    func showCover(of cover : Cover)
    {
         let coverVC = storyboard?.instantiateViewController(withIdentifier: "CoverViewController") as! CoverViewController
        
        coverVC.hidesBottomBarWhenPushed = true
        coverVC.cover = cover
         navigationController?.view.backgroundColor = .white
        navigationController?.pushViewController(coverVC, animated: true)

    }
}
