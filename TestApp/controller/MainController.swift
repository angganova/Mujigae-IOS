//
//  ViewController.swift
//  TestApp
//
//  Created by Ania on 15/04/19.
//  Copyright © 2019 FullStackDiv. All rights reserved.
//

import UIKit

class MainController : UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout{

    
    //    Data
    var stringData:[String] = [
    "Topokki", "Sundubu", "Galbitang", "Beef BBQ", "Korean Fried Chicken",
    "Bingsoo", "Dakgalbi", "Ramyun", "Bulgogi", "Anyeong Set 1",
    "Nori", "Mandu", "Kimchi", "Beef", "Anyeong Set 1", "Chooko Bingsoo",
    "Bokumbap", "Bulgogi Bibimbowl", "Clasic Bingsoo", "Matcha", "Japchae",
    "Yogurt Bingsoo", "Korean Lemonade", "Matha Milk Tea", "Choco Banana Milk",
    "Jeju Orange Tea", "Apple Tea", "Mineral Water", "Tea"
    ]
    
    var data = [DataModel]()
    let list_cell = "ItemGrid"

    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvSubtitle: UILabel!
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var btDone: UIButton!
    
    var redColor: UIColor?
    var grayColor: UIColor?
    
    var dataToSend = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvTitle.text = "Personalize your Favorite Menu at Mujigae"
        tvSubtitle.text = "Pick 3 or more category of menu you are currently looking ( you can changethem anytime )"
        
        redColor = hexStringToUIColor(hex: "#EBA1A1")
        grayColor = hexStringToUIColor(hex: "#AAAAAA")
        
        self.cv.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        
        addData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "nextVC"){
            let vc = segue.destination as! NextController
            vc.subtitle = self.dataToSend
        }
    }
    
    func addData(){
        for x in stringData.indices {
            self.data.append(DataModel(
                id: String(x),
                name:stringData[x]
            ))
        }
        
        setBaseView()
    }
    
    @IBAction func btDoneAct(_ sender: UIButton) {
        prepareData()
    }
    
    func setBaseView(){
        btDone.titleLabel?.textColor = UIColor.white
        btDone.layer.backgroundColor = redColor?.cgColor
        
        
        self.cv.register(UINib(nibName: list_cell, bundle: nil), forCellWithReuseIdentifier: list_cell)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let textWidth = data[indexPath.row].name.size(withAttributes: nil)
        return CGSize(width: textWidth.width*2, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: list_cell, for: indexPath as IndexPath
            ) as! ItemGrid
        
        cell.setColor(selectedColor: redColor!,
                         unSelectedColor: grayColor!)
        
        if(self.data[indexPath.row].selected){
            cell.displaySelected(label: self.data[indexPath.row].name)
        } else {
           cell.displayUnselected(label: self.data[indexPath.row].name)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (data[indexPath.row].selected) {
            data[indexPath.row].selected = false
            cv.reloadItems(at: [indexPath])
        } else {
            data[indexPath.row].selected = true
            cv.reloadItems(at: [indexPath])
        }
    }
    
    
    func prepareData(){
        var counter = 1
        
        self.dataToSend = ""
        
        for x in data{
            if(x.selected){
                self.dataToSend.append(String(counter) + ". " + x.name + "\n")
                counter += 1
            }
        }
        
        let sendAlert = UIAlertController(title: "Confirm", message: "Done picking your favorite?",
                                             preferredStyle: UIAlertController.Style.alert)
        
        UILabel.appearance(whenContainedInInstancesOf: [UIAlertController.self]).numberOfLines = 0
        sendAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.performSegue(withIdentifier: "nextVC", sender: self)
        }))
        
        sendAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            sendAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(sendAlert, animated: true, completion: nil)
    }

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
