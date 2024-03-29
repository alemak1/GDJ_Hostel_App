//
//  AppDelegate.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/23/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "AppDelegate.h"

#import "HostelInformationController.h"
#import "KoreanAudioPhraseController.h"
#import "HostelCollectionController.h"
#import "TouristSiteCollectionViewController.h"
#import "HostelFlowLayout.h"
#import "HostelInformationController.h"


@interface AppDelegate ()

typedef enum TESTABLE_VIEWCONTROLLERS{
    HOSTEL_INFORMATION_CONTROLLER,
    KOREAN_AUDIO_PHRASE_CONTROLLER,
    HOSTEL_COLLECTION_CONTROLLER,
    TOURIST_SITE_COLLECTION_VIEW_CONTROLLER
} TESTABLE_VIEWCONTROLLERS;

@property UIImage* cachedLandscapeImage;
@property UIImage* cachedPortraitImage;

@property (readonly) HostelInformationController* hostelInformationController;

@end

@implementation AppDelegate

static BOOL willInitiateFromStoryBoard = false;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    if(!willInitiateFromStoryBoard){
        self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
        
        UIViewController* rootViewController = [self getTestableViewController:HOSTEL_INFORMATION_CONTROLLER];
        
        [self.window setRootViewController:rootViewController];
        
        
        NSLog(@"RootViewController has been set to %@",[rootViewController description]);
        
        [self.window makeKeyAndVisible];
    }
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(UIViewController*) getTestableViewController:(TESTABLE_VIEWCONTROLLERS)testableViewControllerType{
    
    
    HostelFlowLayout* hostelFlowLayout = [[HostelFlowLayout alloc]initWithPresetVerticalConfigurationA];
    

    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setItemSize:CGSizeMake(300, 100)];
    [flowLayout setMinimumLineSpacing:30.0];
    [flowLayout setMinimumInteritemSpacing:40.0];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    UIViewController* testableViewController = nil;
    
    
    switch (testableViewControllerType) {
        case HOSTEL_INFORMATION_CONTROLLER:
            testableViewController = [[HostelInformationController alloc] init];
            break;
        case KOREAN_AUDIO_PHRASE_CONTROLLER:
            testableViewController = [[UINavigationController alloc] initWithRootViewController:[[KoreanAudioPhraseController alloc] init]];
            break;
        case HOSTEL_COLLECTION_CONTROLLER:
            testableViewController = [[HostelCollectionController alloc] init];
            break;
        case TOURIST_SITE_COLLECTION_VIEW_CONTROLLER:
            break;
        default:
            break;
     
    }
    
    return testableViewController;
}



#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"VisitedSiteTracker"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



-(void) preloadSnapshotForPrimaryDeviceOrientation{
    MKMapSnapshotOptions* snapShotOptions = [[MKMapSnapshotOptions alloc] init];
    
    [snapShotOptions setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.542103, 126.9433582), MKCoordinateSpanMake(10.0,10.0))];
    [snapShotOptions setMapType:MKMapTypeSatelliteFlyover];
    [snapShotOptions setShowsPointsOfInterest:NO];
    [snapShotOptions setSize:[[UIScreen mainScreen] bounds].size];
    
    MKMapSnapshotter* snapShotter = [[MKMapSnapshotter alloc] initWithOptions:snapShotOptions];
    
    [snapShotter startWithCompletionHandler:^(MKMapSnapshot* snapShot, NSError* error){
        
        if(error){
            NSLog(@"Error: snapshotter object failed to capture map image with error: %@",[error localizedDescription]);
            return;
        }
        
        if(!snapShot){
            NSLog(@"Error: no shapshot available.");
            return;
        }
        
        
        if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait){
            self.cachedPortraitImage = [snapShot image];
           
            if(self.hostelInformationController){
                
                self.hostelInformationController.cachedPortraitImage = [snapShot image];
            }
            
        }
        if([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight){
            self.cachedLandscapeImage = [snapShot image];
            
            if(self.hostelInformationController){
                
                self.hostelInformationController.cachedLandscapeImage = [snapShot image];
            }
        }
        
        
        NSLog(@"Snapshot image obtained for primary device orientation %@",[[snapShot image] description]);
        
    }];
}

-(void)preloadSnapshotForAlternateDeviceOrientation{
    
    MKMapSnapshotOptions* snapShotOptions = [[MKMapSnapshotOptions alloc] init];
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.height;
    CGFloat height = [[UIScreen mainScreen] bounds].size.width;
    
    CGSize alternateSize = CGSizeMake(width, height);
    
    [snapShotOptions setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.542103, 126.9433582), MKCoordinateSpanMake(10.0,10.0))];
    [snapShotOptions setMapType:MKMapTypeSatelliteFlyover];
    [snapShotOptions setShowsPointsOfInterest:NO];
    [snapShotOptions setSize:alternateSize];
    
    
    MKMapSnapshotter* snapShotter = [[MKMapSnapshotter alloc] initWithOptions:snapShotOptions];
    
    [snapShotter startWithCompletionHandler:^(MKMapSnapshot* snapShot, NSError* error){
        
        if(error){
            NSLog(@"Error: snapshotter object failed to capture map image with error: %@",[error localizedDescription]);
            return;
        }
        
        if(!snapShot){
            NSLog(@"Error: no shapshot available.");
            return;
        }
        
        
        if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait){
            self.cachedLandscapeImage = [snapShot image];
            
            if(self.hostelInformationController){
                
                self.hostelInformationController.cachedLandscapeImage = [snapShot image];
            }
        }
        if([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight){
            self.cachedPortraitImage = [snapShot image];
            
            if(self.hostelInformationController){
                
                self.hostelInformationController.cachedPortraitImage = [snapShot image];
            }
        }
        
         NSLog(@"Snapshot image obtained for alternate device orientation %@",[[snapShot image] description]);
    }];
}


-(HostelInformationController *)hostelInformationController{
    
    HostelInformationController* hostelInformationController = (HostelInformationController*)self.window.rootViewController;
    
    return hostelInformationController;
}

@end
