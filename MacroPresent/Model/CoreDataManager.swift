//
//  CoreDataManager.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 04/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Foundation
import Cocoa

public class CoreDataManager{
    
//    static let shared = CoreDataManager()
    
//    private let delegate = NSApplication.shared.delegate as! AppDelegate
//    private var context: NSManagedObjectContext!
    
//    init(){
//        context = delegate.persistentContainer.viewContext
//    }
    
    private static func getContext() -> NSManagedObjectContext{
//        let delegate = NSApplication.shared.delegate as! AppDelegate
//        return delegate.persistentContainer.viewContext

        let container = NSPersistentContainer(name: "MacroPresent")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error)")
            }
        })
        return container.viewContext
    }
    
    private static let context = getContext()
    
    public static func fetchPractices() -> [cPractice]{

        var practices: [cPractice] = []
        
        let request = Practice.createFetchRequest()
        
        do {
            let practiceResult = try context.fetch(request)
            
            if practiceResult.isEmpty{
                print("Nothing inside practice entity")
                return practices
            } else {
                for data in practiceResult{
                    
                    var newSlides: [cSlide] = []
                    for slide in data.slides.compactMap({($0 as! Slide)}){
                        let currentSlide = cSlide(
                            number: Int(slide.slideNumber),
                            time: Int(slide.slideTime),
                            preview: slide.slidePreview
                        )
                        newSlides.append(currentSlide)
                    }
                    
                    var newWPMs: [cWPM] = []
                    for wpm in data.wpm.compactMap({($0 as! WPM)}){
                        let currentWPM = cWPM(
                            position: Int(wpm.position),
                            wordsPerMinute: Int(wpm.wordsPerMinute),
                            audioPath: wpm.audioPath,
                            slideNumber: Int(wpm.slideNumber)
                        )
                        newWPMs.append(currentWPM)
                    }
                    
                    let newPractice = cPractice(
                        ID: data.id,
                        keynoteName: data.keynoteName,
                        keynotePreview: data.keynotePreview,
                        maxDuration: Int(data.maxDuration),
                        totalTime: Int(data.totalTime),
                        slides: newSlides,
                        WPMs: newWPMs
                    )
                    
                    practices.append(newPractice)
                }
                print("Practices fetched")
            }
            
        } catch {
            print("Error in 'fetchPractices' | ERROR: \(error)")
        }
        
        return practices
    }
    
    public static func save(practice newData: cPractice) -> Bool{
        
        var slides: [Slide] = []
        for slide in newData.slides{
            let newSlide = Slide(context: context)
            newSlide.slideNumber = Int32(slide.number)
            newSlide.slideTime = Int32(slide.time)
            newSlide.slidePreview = slide.preview
            slides.append(newSlide)
        }
        
        var WPMs: [WPM] = []
        for wpm in newData.WPMs{
            let newWPM = WPM(context: context)
            newWPM.position = Int32(wpm.position)
            newWPM.wordsPerMinute = Int32(wpm.wordsPerMinute)
            newWPM.audioPath = wpm.audioPath
            newWPM.slideNumber = Int32(wpm.slideNumber)
            WPMs.append(newWPM)
        }
        
        let practice = Practice(context: context)
        practice.id = newData.ID
        practice.keynoteName = newData.keynoteName
        practice.keynotePreview = newData.keynotePreview
        practice.maxDuration = Int32(newData.maxDuration)
        practice.totalTime = Int32(newData.totalTime)
        practice.slides = NSSet(array: slides)
        practice.wpm = NSSet(array: WPMs)
        

        do {
            try context.save()
            print("Practice saved")
            return true
        } catch {
            print("Error saving data")
            return false
        }
    }
    
    public static func delete(practice newData: cPractice) -> Bool{
        
        let request = Practice.createFetchRequest()

        request.predicate = NSPredicate(format: "id == %@", newData.ID as CVarArg)
        
        do {
            let practiceResult = try context.fetch(request)
            
            for practice in practiceResult {
                if (practice.id == newData.ID){
                    let objectToDelete = practice
                    context.delete(objectToDelete)
                }
            }
            
            do {
                try context.save()
                print("Practice \(newData.ID) deleted")
                return true
            } catch  {
                print("Failed deleting challenge")
                return false
            }

        } catch{
            print(error)
            return false
        }
    }
    
    public static func update(practice newData: cPractice) -> Bool{
        
        let request = Practice.createFetchRequest()

        request.predicate = NSPredicate(format: "id == %@", newData.ID as CVarArg)
        
        do {
            let practiceResult = try context.fetch(request)
            
            for practice in practiceResult {
                if (practice.id == newData.ID){
                    //TODO: What will be updated?
                }
            }
            
            do {
                try context.save()
                print("Practice \(newData.ID) updated")
                return true
            } catch  {
                print("Failed deleting challenge")
                return false
            }

        } catch{
            print(error)
            return false
        }
    }
    
    public static func deleteAllPractices() -> Bool{
        let request = Practice.createFetchRequest()

        do {
            let practiceResult = try context.fetch(request)
            
            for practice in practiceResult {
                let objectToDelete = practice
                context.delete(objectToDelete)
            }
            
            do {
                try context.save()
                print("All practices deleted")
                return true
            } catch  {
                print("Failed deleting challenge")
                return false
            }

        } catch{
            print(error)
            return false
        }
    }
}
