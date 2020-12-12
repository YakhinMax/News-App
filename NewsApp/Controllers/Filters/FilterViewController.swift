//
//  FilterViewController.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 12.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    var sourceDelegate = SourceFilterDelegate()
    var countryDelegate = CountryFilterDelegate()
    var categoryDelegate = CategoryFilterDelegate()

    @IBOutlet weak var sourcePickerView: UIPickerView!
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourcePickerView.delegate = sourceDelegate
        sourcePickerView.dataSource = sourceDelegate
        countryPickerView.delegate = countryDelegate
        countryPickerView.dataSource = countryDelegate
        categoryPickerView.delegate = categoryDelegate
        categoryPickerView.dataSource = categoryDelegate
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
