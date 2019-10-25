//
//  Meal+CoreDataClass.swift
//  PhotosCoreData
//
//  Created by Steven Perrin on 10/24/19.
//  Copyright © 2019 Steven Perrin. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Meal)
public class Meal: NSManagedObject {
    
    var image: UIImage? {
        get {
            if let imageData = rawImage as Data? {
                return UIImage(data: imageData)
            }
            return nil
        } set {
            let imageData = newValue!.pngData() as NSData?
            rawImage = imageData as Data?
        }
    }
    
    var modifiedDate: Date?{
        get{
            return rawDate as Date?
        } set {
            rawDate = newValue as NSDate? as Date?
        }
    }

    
    convenience init?(title: String?, location: String?, image: UIImage?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate  //UIKit is needed to access UIApplication
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            let title = title, title != "" else {
                           return nil
                   }
            
        self.init(entity: Meal.entity(), insertInto: managedContext)
        self.title = title
        self.location = location
        self.image = image
        
        self.modifiedDate = Date(timeIntervalSinceNow: 0)
        
    }
    
    func update(title: String, location: String, image: UIImage) {
        self.title = title
        self.location = location
        self.image = image
        
        
         self.modifiedDate = Date(timeIntervalSinceNow: 0)
    }



}
