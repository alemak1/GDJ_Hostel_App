//
//  AppDelegate.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/23/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "AppDelegate.h"

#import "HostelInformationController.h"
#import "KoreanAudioPhraseController.h"
#import "HostelCollectionController.h"
#import "TouristSiteCollectionViewController.h"
#import "HostelFlowLayout.h"

@interface AppDelegate ()

typedef enum TESTABLE_VIEWCONTROLLERS{
    HOSTEL_INFORMATION_CONTROLLER,
    KOREAN_AUDIO_PHRASE_CONTROLLER,
    HOSTEL_COLLECTION_CONTROLLER,
    TOURIST_SITE_COLLECTION_VIEW_CONTROLLER
} TESTABLE_VIEWCONTROLLERS;

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


@end
