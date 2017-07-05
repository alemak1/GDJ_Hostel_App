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
#import "TouristSiteManager.h"

@interface UserLocationManager : CLLocationManager


+(UserLocationManager*) sharedLocationManager;


@property TouristSiteManager* siteManager;

-(void) requestAuthorizationAndStartUpdates;

-(void)startMonitoringForRegions:(NSSet<CLRegion*>*)regions;
-(void)stopMonitoringForRegions:(NSSet<CLRegion*>*)regions;
-(void)startMonitoringForSingleRegion:(CLRegion*)region;
-(void)stopMonitoringForSingleRegion:(CLRegion*)region;



-(CLLocation*)getLastUpdatedUserLocation;

-(void)setPresentingViewControllerTo:(UIViewController*)presentingViewController;
-(BOOL)isBeingRegionMonitored:(NSString*)regionIdentifier;
-(CLRegion*)getRegionWithIdentifier:(NSString*)regionIdentifier;


-(void)viewLocationInMapsTo:(CLLocationCoordinate2D)regionCenter;
-(void)viewLocationInMapsFromHostelTo:(CLLocationCoordinate2D)toLocationCoordinate;

@end

#endif /* AppLocationManager_h */
