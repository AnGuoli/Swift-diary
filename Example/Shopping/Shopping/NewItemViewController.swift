//
//  NewItemViewController.swift
//  Shopping
//
//  Created by 金亮齐 on 2017/2/28.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {
    
    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var brandNameTextField: UITextField!

    @IBAction func saveItem(sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}