//
//  EditTableViewCell.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/16/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit

class PeriodViewCell: UITableViewCell, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var pgField: UITextField!
    @IBOutlet weak var ifField: UITextField!
    @IBOutlet weak var cuotaLabel: UILabel!
    
    let pgTypes = ["S","P","T"]
    var currentSelection: String = ""
    var pickerView = UIPickerView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pickerView.delegate = self
        self.pickerView.backgroundColor = UIColor.white

        self.pgField.inputView = self.pickerView
        self.pgField.delegate = self
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = self.pgTypes[row]
        label.sizeToFit()
        return label;
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pgTypes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pgTypes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pgField.text = self.pgTypes[row]
        self.currentSelection = self.pgTypes[row]
        self.endEditing(true)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
