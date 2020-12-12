//
//  SourceFilterDelegate.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 12.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

class SourceFilterDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var sources : [String] = ["All"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        sources.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sources[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if sources[row] == "All" {
            NewsClient.shared.removeFilterKey(key: "source")
        }
        NewsClient.shared.removeFilterKey(key: "country")
        NewsClient.shared.removeFilterKey(key: "category")
        NewsClient.shared.addFilter(key: "source", value: sources[row])
    }
}
