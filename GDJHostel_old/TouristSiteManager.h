//
//  TouristSiteManager.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef TouristSiteManager_h
#define TouristSiteManager_h

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "TouristSiteConfiguration.h"

@interface TouristSiteManager : NSObject


-(instancetype)initWithFileName:(NSString*)fileName;

-(instancetype)initWithFileName:(NSString*)fileName andWithTouristSiteCategory:(TouristSiteCategory)category;

-(NSInteger)totalNumberOfTouristSitesInMasterArray;
-(TouristSiteConfiguration*)getConfigurationObjectFromMasterArray:(NSInteger)index;
-(TouristSiteConfiguration*)getConfigurationForRegionIdentifier:(NSString*)regionIdentifier;

-(TouristSiteConfiguration*) getTouristSiteClosestToUser;


/** Site filtering functions **/

- (NSArray<TouristSiteConfiguration*>*)getArrayForMaxAdmissionFee:(CGFloat)maxAdmissionFee andMaxDistance:(CGFloat)maxDistanceFromUser andForCategory:(TouristSiteCategory)touristSiteCategory;

- (NSArray<TouristSiteConfiguration*>*)getArrayForMaximumTravelingTime:(CGFloat)maxTravelingTime andMaxDistance:(CGFloat)maxDistanceFromUser andForCategory:(TouristSiteCategory)touristSiteCategory;

- (NSArray<TouristSiteConfiguration*>*)getArrayForMaximumTravelingTime:(CGFloat)maxTravelingTime;

- (NSArray<TouristSiteConfiguration*>*)getArrayForMaximumDistanceFromUser:(CGFloat)maximumDistanceFromUser;

- (NSArray<TouristSiteConfiguration*>*)getArrayForTouristSiteCategory:(TouristSiteCategory)touristSiteCategory;


-(NSArray<CLRegion*>*)getRegionsForAllTouristLocations;

-(void) filterForTouristSiteCategory:(TouristSiteCategory)category;

-(NSString*) abbreviatedDebugDescription;
-(NSString*) detailedDebugDescription;

@end

#endif /* TouristSiteManager_h */
