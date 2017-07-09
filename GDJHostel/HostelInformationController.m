//
//  HostelInformationController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/24/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostelInformationController.h"
#import "MenuComponent.h"
#import "AppLocationManager.h"

#import "TouristSiteManager.h"
#import "Visitation.h"

@interface HostelInformationController ()

@property (nonatomic, strong) MenuComponent *menuComponent;
@property UIImageView* backgroundImageView;

- (void)showMenu:(UIGestureRecognizer *)gestureRecognizer;


@end

@implementation HostelInformationController

-(void)saveVisitation:(Visitation*)visitation key:(NSString*)key{
    NSData* encodedObject = [NSKeyedArchiver archivedDataWithRootObject:visitation];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
}

-(Visitation*)loadVisitationWithKey:(NSString*)key{
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSData* encodedObject = [defaults objectForKey:key];
    Visitation* visitation = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    return visitation;
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    /** Initialize the user location manager and set its presenting view controller **/
    
    UserLocationManager* userLocationManager = [UserLocationManager sharedLocationManager];
    
    [userLocationManager setPresentingViewControllerTo:self];
    
    [userLocationManager requestAuthorizationAndStartUpdates];
    
    /**
    TouristSiteManager* siteManager = [[TouristSiteManager alloc] initWithFileName:@"SeoulTouristSites"];
    
    NSSet* set = [NSSet setWithArray:[siteManager getRegionsForAllTouristLocations]];
    
    [userLocationManager startMonitoringForRegions:set];
    

    for (CLRegion*region in [userLocationManager monitoredRegions]) {
        Visitation* newVisitation = [[Visitation alloc] initWithRegionIdentifier:region.identifier];
        
        [self saveVisitation:newVisitation key:region.identifier];
    }
 
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4.00*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        for (CLRegion*region in [userLocationManager monitoredRegions]) {
            Visitation* visitation = [self loadVisitationWithKey:region.identifier];
            
            [visitation setExitTime:[NSDate date]];
            
            NSLog(@"The site was %@ visited for a period: %@",region.identifier,[visitation visitationTimeString]);
            
            
        }
    
    });
    
    **/
    
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}



-(void)viewDidLoad{
    [super viewDidLoad];
   
    UISwipeGestureRecognizer *showMenuGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    
    showMenuGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:showMenuGesture];
    
    CGRect desiredMenuFrame = CGRectMake(0.0, 0.0, 300.0, self.view.frame.size.height);
    self.menuComponent = [[MenuComponent alloc] initMenuWithFrame:desiredMenuFrame
                    targetView:self.view
                    direction:menuDirectionRightToLeft
                    options:@[@"About Hostel", @"Explore Nearby", @"Visited Sites", @"Seoul Tourism",@"Weather",@"Survival Korean", @"Product Prices",@"Monitored Regions",@"Seoul Image Galleries"]
                    optionImages:@[@"informationB", @"compassB", @"paintingB", @"templeB",@"cloudyA",@"chatA", @"shoppingCartB",@"mapAddressB",@"tvA"]];

}


- (void)showMenu:(UIGestureRecognizer *)gestureRecognizer {
    [self.menuComponent showMenuWithSelectionHandler:^(NSInteger selectedOptionIndex) {
        
        UIStoryboard* storyBoardA = [UIStoryboard storyboardWithName:@"StoryboardA" bundle:nil];
        
        UIStoryboard* storyBoardB = [UIStoryboard storyboardWithName:@"StoryboardB" bundle:nil];
        
        UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController* requestedViewController;
        
        switch (selectedOptionIndex) {
            case 0:
                //Information about hostel
                requestedViewController = [self getInformationControllerFromStoryBoard];
                NSLog(@"You selected option %d",(int)selectedOptionIndex);
                break;
            case 1:
                //Directions
                 requestedViewController = [storyBoardA instantiateViewControllerWithIdentifier:@"DirectionsMenuController"];
                    NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 2:
                //Contact info
                 requestedViewController = [storyBoardA instantiateViewControllerWithIdentifier:@"DirectionsMenuController"];
                    NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 3:
                //Seoul tourism
                 requestedViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SeoulTourismNavigationController"];
                    NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 4:
                //Weather
                 requestedViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"WeatherNavigationController"];
                NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 5:
                //Korean Phrases Audio
                break;
            case 6:
                //Korean Product Prices
                requestedViewController = [storyBoardB instantiateViewControllerWithIdentifier:@"ProductPriceNavigationController"];
                break;
            case 7:
                requestedViewController = [self getMonitoredRegionsControllerFromStoryboard];
                break;
            case 8:
                //Seoul Picture Gallery
                requestedViewController = [self getSeoulFlickrSearchController];
                
                NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            default:
                break;
        }
        
        [self showViewController:requestedViewController sender:nil];

    }];
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [self.menuComponent resetMenuView:[self traitCollection]];
}


-(UIViewController*)getSeoulFlickrSearchController{
    
    UIStoryboard* storyboardB = [UIStoryboard storyboardWithName:@"StoryboardB" bundle:nil];
    
    
    NSString *storyBoardIdentifier = @"SeoulFlickrSearchController_iPad";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        storyBoardIdentifier = @"SeoulFlickrSearchController";
    }
    
    
    return [storyboardB instantiateViewControllerWithIdentifier:storyBoardIdentifier];
    
}

-(UIViewController*)getMonitoredRegionsControllerFromStoryboard{
    
    UIStoryboard* storyboardB = [UIStoryboard storyboardWithName:@"StoryboardB" bundle:nil];
    
    
    NSString *storyBoardIdentifier = @"MonitoredRegionsController_iPad";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        storyBoardIdentifier = @"MonitoredRegionsController";
    }
    
    
    return [storyboardB instantiateViewControllerWithIdentifier:storyBoardIdentifier];
    
}

-(UIViewController*)getInformationControllerFromStoryBoard{
    
    // decide which kind of content we need based on the device idiom,
    // when we load the proper storyboard, the "ContentController" class will take it from here
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    NSString *storyBoardIdentifier = @"PadInformationController";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        storyBoardIdentifier = @"PhoneInformationController";
    }
    
    
    return [mainStoryBoard instantiateViewControllerWithIdentifier:storyBoardIdentifier];
    
}


-(IBAction)unwindBackToHostelIndexPage:(UIStoryboardSegue *)unwindSegue{
    
}

@end


/**
 
 
 
 
 __block CLLocation* userLocation = [userLocationManager getLastUpdatedUserLocation];
 
 if(userLocation == nil){
 
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 6.00*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
 
 userLocation = [userLocationManager getLastUpdatedUserLocation];
 
 
 NSLog(@"The user location after 6.00 secondss is lat: %f, long: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
 
 
 TouristSiteConfiguration* site = [siteManager getTouristSiteClosestToUser];
 
 NSLog(@"The tourist site closest to the user is: %@",[site title]);
 
 NSArray* closeSitesArray = [siteManager getArrayForTouristSiteCategory:KOREAN_WAR_MEMORIAL];
 
 
 NSLog(@"The museums are:");
 
 for (TouristSiteConfiguration*site in closeSitesArray) {
 NSLog(@"Name: %@",site.title);
 }
 });
 }
 
**/
