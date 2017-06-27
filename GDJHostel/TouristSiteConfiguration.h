//
//  TouristSiteConfiguration.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef TouristSiteConfiguration_h
#define TouristSiteConfiguration_h

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "OverlayConfiguration.h"

@interface TouristSiteConfiguration : OverlayConfiguration

typedef enum DayOfWeek{
    MONDAY = 1,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY,
    SUNDAY
}DayOfWeek;


typedef enum TouristSiteCategory{
    MUSUEM = 0,
    TEMPLE,
    MONUMENT_OR_WAR_MEMORIAL,
    SHOPPING_AREA,
    NIGHT_MARKET,
    RADIO_TOWER,
    NATURAL_SITE,
    PARK,
}TouristSiteCategory;


/** User-Initialized Properties **/

@property NSString* title;
@property NSString* siteDescription;
@property CGFloat admissionFee;

@property int* daysClosed;
@property TouristSiteCategory touristSiteCategory;

@property NSNumber* openingTime;
@property NSNumber* closingTime;
@property NSString* physicalAddress;
@property NSString* webAddress;
@property NSString* specialNote;

/** Computed properties determined dynamically based on local time and user location info **/

@property (readonly) BOOL isOpen;
@property (readonly) NSDate* timeUntilClosing;
@property (readonly) NSDate* timeUntilOpening;

@property (readonly) CGFloat distanceFromUser;
@property (readonly) CGFloat travelingTimeFromUserLocation;

/** Initializers **/

-(instancetype)initWithConfigurationDict:(NSDictionary*)configurationDictionary;
- (instancetype)initWithFilename:(NSString *)filename;

-(NSString*)debugDescriptionA;
-(NSString*)debugDescriptionB;

@end

#endif /* TouristSiteConfiguration_h */
