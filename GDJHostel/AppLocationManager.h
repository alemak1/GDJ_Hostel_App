//
//  AppLocationManager.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/27/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef AppLocationManager_h
#define AppLocationManager_h

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UserLocationManager : CLLocationManager


+(UserLocationManager*) sharedLocationManager;

-(void) requestAuthorizationAndStartUpdates;

-(void)startMonitoringForRegions:(NSArray<CLRegion*>*)regions;
-(void)stopMonitoringForRegions:(NSArray<CLRegion*>*)regions;

-(CLLocation*)getLastUpdatedUserLocation;

-(void)setPresentingViewControllerTo:(UIViewController*)presentingViewController;


@end

#endif /* AppLocationManager_h */
