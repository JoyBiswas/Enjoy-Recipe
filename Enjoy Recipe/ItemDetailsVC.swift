//
//  ItemDetailsVC.swift
//  Enjoy Recipe
//
//  Created by MacBook Air on 12/5/17.
//  Copyright © 2017 MacBook Air. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var typePicker:UIPickerView!
    @IBOutlet weak var titleField:CustomTextField!
    @IBOutlet weak var timeField:CustomTextField!
    @IBOutlet weak var ingredientsField:CustomTextField!
    @IBOutlet weak var stepsField:CustomTextField!
    
    @IBOutlet weak var thumgImg: UIImageView!
    
    var itemtype = [Itemtype]()
    var itemToEdit: Item?
    var imagePicker:UIImagePickerController!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
            
        }
        
        typePicker.delegate = self
        typePicker.dataSource = self
        
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
 
        let itemtype = Itemtype(context: context)
         itemtype.type = "Bread,Muffins & Scones"
        let itemtype1 = Itemtype(context: context)
        itemtype1.type = "Breakfast"
        let itemtype2 = Itemtype(context: context)
        itemtype2.type = "Desserts"
        let itemtype3 = Itemtype(context: context)
        itemtype3.type = "Dinner"
        let itemtype4 = Itemtype(context: context)
        itemtype4.type = "Dips,Salad,salsa,sauces"
        let itemtype5 = Itemtype(context: context)
        itemtype5.type = "Drings"
        let itemtype6 = Itemtype(context: context)
        itemtype6.type = "Lunch"
        let itemtype7 = Itemtype(context: context)
        itemtype7.type = "One Pot Meal"
        let itemtype8 = Itemtype(context: context)
        itemtype8.type = "Pancakes"
        let itemtype9 = Itemtype(context: context)
        itemtype9.type = "Salad"
        let itemtype10 = Itemtype(context: context)
        itemtype10.type = "Side Dishes"
        let itemtype11 = Itemtype(context: context)
        itemtype11.type = "Snaks"
        let itemtype12 = Itemtype(context: context)
        itemtype12.type = "Soups,Stwes&Chili"
        let itemtype13 = Itemtype(context: context)
        itemtype13.type = "Sweets"
        
        ad.saveContext()
        getitemTypes()
        
        if itemToEdit != nil {
            
            loadItemData()
        }
  }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return itemtype.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let type = itemtype[row]
        
        return type.type
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }
    
    func getitemTypes() {
        
        let fetchRequest: NSFetchRequest<Itemtype> = Itemtype.fetchRequest()
        
        do {
            
            self.itemtype = try context.fetch(fetchRequest)
            self.typePicker.reloadAllComponents()
            
        } catch {
            
            // handle the error
        }
    }
    
    
    
    
    
    
    
    @IBAction func SavePressed(_ sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumgImg.image
        
        if itemToEdit == nil {
            
            item = Item(context: context)
            
        } else {
            
            item = itemToEdit
            
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            
            item.title = title
            
        }
        
        if let time = timeField.text {
            
            item.time = (time as NSString).doubleValue
            
        }
        
        if let ingredients = ingredientsField.text {
            
            item.ingredients = ingredients
            
        }
        
        if let steps = stepsField.text {
            
            item.steps = steps
        }
        
        item.toItemtype = itemtype[typePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
     
        
        
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            timeField.text = "\(item.time)"
            ingredientsField.text = item.ingredients
            stepsField.text = item.steps
            thumgImg.image = item.toImage?.image as? UIImage
            
            
            if let type = item.toItemtype {
                
                var index = 0
                repeat {
                    
                    let s = itemtype[index]
                    if s.type == type.type {
                        
                        typePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < itemtype.count)
            }
        }
        
        
        
    }
    
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumgImg.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
