//
//  NextController.swift
//  TestApp
//
//  Created by Ania on 16/04/19.
//  Copyright © 2019 FullStackDiv. All rights reserved.
//

import UIKit

class NextController: UIViewController{
    
    let titleAbove = "Your Favorite Menu is"
    var subtitle = ""
    
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvSubtitle: UILabel!
    
    
    override func viewDidLoad() {
        
        tvTitle.text = titleAbove
        
        if (subtitle == "") {
            tvSubtitle.text = "No category selected"
        }else{
        tvSubtitle.text = subtitle
        }
    }
    
}
