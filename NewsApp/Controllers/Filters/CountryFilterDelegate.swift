//
//  CountryFilterDelegate.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 12.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

class CountryFilterDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var countries : [String] = ["All", "ae","ar","at","au","be","bg","br","ca","ch","cn","co","cu","cz","de","eg","fr","gb","gr","hk","hu","id","ie","il","in","it","jp","kr","lt","lv","ma","mx","my","ng","nl","no","nz","ph","pl","pt","ro","rs","ru","sa","se","sg","si","sk","th","tr","tw","ua","us","ve","za"]
    // Backend doesn't allow to load all countries
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if countries[row] == "All" {
            NewsClient.shared.removeFilterKey(key: "country")
        }
        NewsClient.shared.removeFilterKey(key: "source")
        NewsClient.shared.addFilter(key: "country", value: countries[row])
    }
}
