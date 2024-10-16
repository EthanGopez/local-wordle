//
//  SettingsVC.swift
//  IP13-Wordle
//
//  Created by Gopez, Ethan A on 4/2/24.
//

import UIKit

class SettingsVC: UIViewController {
    var vc : GameVC!
    
    @IBOutlet var sw: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sw.setOn(UserDefaults.standard.bool(forKey: "WORDLE-Dark"), animated: false)
        super.viewWillAppear(animated)
    }
    
    @IBAction func darkModeSwitched(_ sender: UISwitch) {
        UserDefaults.standard.setValue(sender.isOn, forKey: "WORDLE-Dark")
        vc.setColor(sender.isOn)
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
