//
//  sixminApp.swift
//  sixmin
//
//  Created by tuan.nguyenv on 10/14/20.
//

import SwiftUI
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate {
    var manageObjectContext: NSManagedObjectContext!
    static var originalAppDelegate: AppDelegate!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        manageObjectContext = CoreDataHelper().persistentContainer.viewContext
        AppDelegate.originalAppDelegate = self
        
        return true
    }
}


@main
struct sixminApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase{
            case .background:
                print("background")
            case .inactive:
                print("inactive")
            case .active:
                print("active")
            @unknown default:
                print("default")
            }
        }
    }
}

struct sixminApp_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
