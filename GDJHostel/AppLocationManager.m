//
//  AppLocationManager.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/27/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppLocationManager.h"



/** Additional functionality: user can opt to monitor for notifications when close to a tourist area (a detail view for the iste can be presented); also, the user can be notified when within a given distance from the hostel **/


//TODO: when the presenting view controller changes to the TouristCategorySelectionController, the tourist regions are added to the store of monitored regions; when the presenting view controller changes to the HostelDirections controller (to be implemented) it monitors for closeness to hostel

//TODO: Use CLLocationManager to monitor for user location updates, not the MKMapItem class method (The ToHostelController will require this to get the route to the hostel).

@interface UserLocationManager () <CLLocationManagerDelegate>

+(NSArray<CLRegion*>*) hostelCircleRegions;

@property CLLocation* lastUpdatedUserLocation;

@property UIViewController* currentPresentingViewController;


@end

@implementation UserLocationManager

static UserLocationManager* mySharedLocationManager;


+(NSArray<CLRegion *> *)hostelCircleRegions{
    
    
    CLLocationCoordinate2D hostelCenterCoordinate = CLLocationCoordinate2DMake(37.5416235, 126.950725);
    
    NSMutableArray<CLRegion*>* hostelCircleRegions = [[NSMutableArray alloc] initWithCapacity:20];
    
    for(int i = 1; i < 21; i++){
        CLCircularRegion* hostelRegion = [[CLCircularRegion alloc] initWithCenter:hostelCenterCoordinate radius:20.00 identifier:[NSString stringWithFormat:@"hostelCircle-%d",i]];
        
        [hostelCircleRegions addObject:hostelRegion];
        
    }
    
    
    return [NSArray arrayWithArray:hostelCircleRegions];


}


-(void)setPresentingViewControllerTo:(UIViewController*)presentingViewController{
    
    self.currentPresentingViewController = presentingViewController;
    
}

+(UserLocationManager*) sharedLocationManager{
    
    if(mySharedLocationManager == nil){
        mySharedLocationManager = [[UserLocationManager alloc] init];
    }
    
    return mySharedLocationManager;
}




-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        [self setDelegate:self];
        [self setDistanceFilter:kCLLocationAccuracyHundredMeters];
        [self setDesiredAccuracy:kCLLocationAccuracyBest];
        
        UserLocationManager* __weak weakSelf = self;
        
        
        /** Register to receive notifications for when the app enter foreground or background so that the app can toggle between standard location monitoring (i.e. the foreground case) and significant location monitoring (i.e. the background case) **/
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            
            if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
                // Stop normal location updates and start significant location change updates for battery efficiency.
                
                [weakSelf stopUpdatingLocation];
                [weakSelf startMonitoringSignificantLocationChanges];
            }
            else {
                NSLog(@"Significant location change monitoring is not available.");
            }
        }];
        
        
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
                // Stop significant location updates and start normal location updates again since the app is in the forefront.
                [weakSelf stopMonitoringSignificantLocationChanges];
                [weakSelf startUpdatingLocation];
            }
            else {
                NSLog(@"Significant location change monitoring is not available.");
            }
            
        
        
        }];
        
    }
    
    
    return self;
}

-(void) requestAuthorizationAndStartUpdates{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        // If status is not determined, then we should ask for authorization.
        [self requestAlwaysAuthorization];
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        // If authorization has been denied previously, inform the user.
        NSLog(@"%s: location services authorization was previously denied by the user.", __PRETTY_FUNCTION__);
        
        // Display alert to the user.
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Location services" message:@"Location services were previously denied by the user. Please enable location services for this app in settings." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}]; // Do nothing action to dismiss the alert.
        
        [alert addAction:defaultAction];
        [self.currentPresentingViewController presentViewController:alert animated:YES completion:nil];
    } else { // We do have authorization.
        // Start the standard location service.
        [self startUpdatingLocation];
    }
}




-(void)startMonitoringForRegions:(NSArray<CLRegion*>*)regions{
    
    for(CLRegion* region in regions){
        
        [region setNotifyOnExit:YES];
        [region setNotifyOnEntry:YES];
        
        [self startMonitoringForRegion:region];
    }
}

-(void)startMonitoringForSingleRegion:(CLRegion*)region{
    [region setNotifyOnExit:YES];
    [region setNotifyOnEntry:YES];
    
    [self startMonitoringForRegion:region];
    
}

-(void)stopMonitoringForSingleRegion:(CLRegion*)region{
    
    [self stopMonitoringForRegion:region];
}


-(BOOL)isBeingRegionMonitored:(NSString*)regionIdentifier{
    
    NSSet* monitoredRegions = [self monitoredRegions];
    
    for (CLRegion* region in monitoredRegions) {
        if([region.identifier isEqualToString:regionIdentifier]){
            return YES;
        }
    }
    
    return NO;
}

-(CLRegion*)getRegionWithIdentifier:(NSString*)regionIdentifier{
    
    NSSet* monitoredRegions = [self monitoredRegions];
    
    for (CLRegion* region in monitoredRegions) {
        if(region.identifier == regionIdentifier){
            return region;
        }
    }
    
    return nil;
}

-(void)stopMonitoringForRegions:(NSArray<CLRegion*>*)regions{
    
    for(CLRegion* region in regions){
        [self stopMonitoringForRegion:region];
    }
}


// When the user has granted authorization, start the standard location service.
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        
        // Start the standard location service.
        [self startUpdatingLocation];
    }
    
    
}

// A core location error occurred.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"didFailWithError: %@", error);
    
}

// The system delivered a new location.
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    // Work around a bug in MapKit where user location is not initially zoomed to.
    if (oldLocation == nil) {
        
        _lastUpdatedUserLocation = newLocation;
        
        NSDictionary* userInfoDict = [NSDictionary dictionaryWithObjectsAndKeys:newLocation,@"userLocation", nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userLocationDidUpdateNotification" object:nil userInfo:userInfoDict];
        
        // Zoom to the current user location.
        /**
        MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 1500.0, 1500.0);
        [self.regionsMapView setRegion:userLocation animated:YES];
         **/
    }
}

// The device entered a monitored region.
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region  {
    NSString *event = [NSString stringWithFormat:@"didEnterRegion %@ at %@", region.identifier, [NSDate date]];
    NSLog(@"%s %@", __PRETTY_FUNCTION__, event);
    
}

// The device exited a monitored region.
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSString *event = [NSString stringWithFormat:@"didExitRegion %@ at %@", region.identifier, [NSDate date]];
    NSLog(@"%s %@", __PRETTY_FUNCTION__, event);
    
}

// A monitoring error occurred for a region.
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSString *event = [NSString stringWithFormat:@"monitoringDidFailForRegion %@: %@", region.identifier, error];
    NSLog(@"%s %@", __PRETTY_FUNCTION__, event);
    
}

-(CLLocation*)getLastUpdatedUserLocation{
    return self.lastUpdatedUserLocation;
}

@end
