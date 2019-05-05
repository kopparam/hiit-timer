//
//  ViewController.swift
//  HIIT timer
//
//  Created by Kashyap Kopparam on 14/4/19.
//  Copyright © 2019 Kashyap Kopparam. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return intervalData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return intervalData[row]
    }
    
    func view(viewForRow row: Int, forComponent component: Int) -> UIView {
        
        
        // Display the first column's width
        // The value 0 is to point to the first column regardless if you have one or multiple columns
        
        let pickerLabel : UILabel = UILabel()
        
        // pickerViewLabelTextForComponentRow is a custom made function to obtain what text will go in each row
        pickerLabel.text = "sss"
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.textColor = UIColor.black
        pickerLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        pickerLabel.backgroundColor = UIColor.lightGray
        
        // If you wish to set up the labels individually in each column, use the value of the parameter component with a control condition such as if or switch
        
        return pickerLabel
    }

    @IBOutlet weak var interval: UIPickerView!

    var intervalData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.interval.delegate = self
        self.interval.dataSource = self
        
        intervalData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    }

    
}
