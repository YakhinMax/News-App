//
//  CategoryFilterDelegate.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 12.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

class CategoryFilterDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var categories : [String] = ["All","business","entertainment","general","health","science","sports","technology"]
    // Backend doesn't allow to load all categories
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if categories[row] == "All" {
            NewsClient.shared.removeFilterKey(key: "category")
        }
        NewsClient.shared.removeFilterKey(key: "source")
        NewsClient.shared.addFilter(key: "category", value: categories[row])
    }
}
