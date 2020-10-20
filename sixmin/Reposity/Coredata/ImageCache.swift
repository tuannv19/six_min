import  SwiftUI
import CoreData

class CoreDataHelper {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ImageCache")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        return container
    }()
    
    func save() {
        if persistentContainer.viewContext.hasChanges{
            do {
                try persistentContainer.viewContext.save()
            } catch  {
                print("error")
            }
        }
    }
}
@objc(ImageCache)
final class ImageCache: NSManagedObject, Identifiable {
    var id: UUID?
    @NSManaged var url: String?
    @NSManaged var data: Data?
    
    func fetchRequest(url: String) -> NSFetchRequest<ImageCache> {
        return NSFetchRequest<ImageCache>(entityName: "Images")
    }
    
    static func imgWith(url: String)-> Data? {
        let request = ImageCache.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        
        if let  appDelegate = AppDelegate.originalAppDelegate {
        let context =  appDelegate.manageObjectContext
        
        do {
            let results = try context?.fetch(request) as! [ImageCache]
            if let result = results.first {
                return result.data
            }
            
        } catch  {
            print(error)
            return nil
        }
    }
        return nil
    }
    
    static func save(url: String, data: Data){
        let appDelegate = AppDelegate.originalAppDelegate
        let context =  appDelegate!.manageObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Images", in: context!)!
        let image = ImageCache(entity: entity, insertInto: context)
        image.url = url
        image.data = data
        image.id = UUID()
        do {
            try context?.save()
        } catch  {
            print(error)
        }
    }
}
