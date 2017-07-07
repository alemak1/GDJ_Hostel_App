//
//  TouristSiteManager.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristSiteManager.h"
#import "TouristSiteConfiguration.h"
#import "AppLocationManager.h"


@interface TouristSiteManager ()


@property NSMutableArray* configurationArray;


@end

@implementation TouristSiteManager

NSArray* _touristSiteDictArray;





-(instancetype)initWithFileName:(NSString*)fileName andWithTouristSiteCategory:(TouristSiteCategory)category{
    
    self = [super init];
    
    if(self){
        NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        
        _touristSiteDictArray = [NSArray arrayWithContentsOfFile:path];
        
        _configurationArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary* dict in _touristSiteDictArray){
            TouristSiteConfiguration* touristSiteConfiguration = [[TouristSiteConfiguration alloc] initWithConfigurationDict:dict];
            
            if(touristSiteConfiguration.touristSiteCategory == category){
                [self.configurationArray addObject:touristSiteConfiguration];

            }
            
        }
        
    }
    
    
    return self;
    
}

-(instancetype)initWithFileName:(NSString*)fileName{
    
    self = [super init];
    
    if(self){
        NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    
        _touristSiteDictArray = [NSArray arrayWithContentsOfFile:path];
        
        _configurationArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary* dict in _touristSiteDictArray){
            TouristSiteConfiguration* touristSiteConfiguration = [[TouristSiteConfiguration alloc] initWithConfigurationDict:dict];
            
        
            [self.configurationArray addObject:touristSiteConfiguration];
        }
    
    }
    
    
    return self;
}


-(NSString*) abbreviatedDebugDescription{
    
    NSString* debugString = @"Tourist Sites: ";
    
    for (TouristSiteConfiguration* configuration in self.configurationArray) {
        
        debugString = [debugString stringByAppendingString:[configuration debugDescriptionA]];
        
    }
    
    return debugString;
    
}

-(NSString*) detailedDebugDescription{
    
    NSString* debugString = @"Tourist Sites: ";
    
    for (TouristSiteConfiguration* configuration in self.configurationArray) {
        
        debugString = [debugString stringByAppendingString:[configuration debugDescriptionB]];
    }
    
    return debugString;
}


#pragma mark COLLECTION VIEW DATA SOURCE METHODS 

-(NSInteger)totalNumberOfTouristSitesInMasterArray{
    return [self.configurationArray count];
}

-(TouristSiteConfiguration*)getConfigurationObjectFromMasterArray:(NSInteger)index{
    
    if(index >= [self.configurationArray count]){
        return nil;
    }
    
    return [self.configurationArray objectAtIndex:index];
}

#pragma mark UTILITY FUNCTIONS FOR ARRAY FILTERING


-(void) filterForTouristSiteCategory:(TouristSiteCategory)category{
    
    self.configurationArray = (NSMutableArray*)[self getArrayForTouristSiteCategory:category];
}

- (NSArray<TouristSiteConfiguration*>*)getArrayForTouristSiteCategory:(TouristSiteCategory)touristSiteCategory{
    
    
    return [self.configurationArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TouristSiteConfiguration* configurationObject, NSDictionary *bindings) {
        
        return [configurationObject touristSiteCategory] == touristSiteCategory;
    }
                                                          ]];
    
}


- (NSArray<TouristSiteConfiguration*>*)getArrayForMaximumTravelingTime:(CGFloat)maxTravelingTime andMaxDistance:(CGFloat)maxDistanceFromUser andForCategory:(TouristSiteCategory)touristSiteCategory{
    
    
    return [self.configurationArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TouristSiteConfiguration* configurationObject, NSDictionary *bindings) {
        
       BOOL travelTimeCondition = [configurationObject travelingTimeFromUserLocation] < maxTravelingTime;
        BOOL distanceCondition = [configurationObject distanceFromUser] < maxDistanceFromUser;
        BOOL siteCategoryConditon = [configurationObject touristSiteCategory] == touristSiteCategory;

        return (distanceCondition && siteCategoryConditon && travelTimeCondition);
        
    }]];
    
}



- (NSArray<TouristSiteConfiguration*>*)getArrayForMaximumTravelingTime:(CGFloat)maxTravelingTime{
    
    
    return [self.configurationArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TouristSiteConfiguration* configurationObject, NSDictionary *bindings) {
        
        return [configurationObject travelingTimeFromUserLocation] < maxTravelingTime;
    }
    ]];
    
}


- (NSArray<TouristSiteConfiguration*>*)getArrayForMaximumDistanceFromUser:(CGFloat)maximumDistanceFromUser{
    
    return [self.configurationArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TouristSiteConfiguration* configurationObject,NSDictionary* bindings){
    
        return [configurationObject distanceFromUser] < maximumDistanceFromUser;
    
    }]];
    
}

- (NSArray<TouristSiteConfiguration*>*)getArrayForAdmissionFee:(CGFloat)admissionFee{
    
    return [self.configurationArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TouristSiteConfiguration* configurationObject, NSDictionary* bindings){
    
        return [configurationObject admissionFee] < admissionFee;
    }]];
}

- (NSArray<TouristSiteConfiguration*>*)getArrayForCurrentlyOpenSites{
    
    return [self.configurationArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TouristSiteConfiguration* configurationObject, NSDictionary* bindingss){
    
        return [configurationObject isOpen];
    }]];
}


-(TouristSiteConfiguration*)getConfigurationForRegionIdentifier:(NSString*)regionIdentifier{
    
    for (TouristSiteConfiguration* siteConfiguration in self.configurationArray) {
        if([siteConfiguration.title isEqualToString:regionIdentifier]){
            return siteConfiguration;
        }
    }
    return nil;
}

-(NSArray<CLRegion*>*)getRegionsForAllTouristLocations{
    
    NSMutableArray* regionArray = [[NSMutableArray alloc] init];
    
    for(TouristSiteConfiguration* siteConfiguration in self.configurationArray){
        
        CLRegion* siteRegion = [siteConfiguration getRegionFromTouristConfiguration];
        
        [regionArray addObject:siteRegion];
    }
   
    return [NSArray arrayWithArray:regionArray];
}


-(TouristSiteConfiguration*) getTouristSiteClosestToUser{
    

    CLLocation* userLocation = [[UserLocationManager sharedLocationManager] getLastUpdatedUserLocation];
    
    NSLog(@"The user's current location is latitude: %f, longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);

    
     TouristSiteConfiguration* closestSiteConfiguration;
    
     CLLocationDistance maxDistance = 0;
    
    
    for(TouristSiteConfiguration* siteConfiguration in self.configurationArray){
        
        
            CLLocation* siteLocation = [[CLLocation alloc] initWithLatitude:siteConfiguration.midCoordinate.latitude longitude:siteConfiguration.midCoordinate.longitude];
            
            CLLocationDistance distanceToLocation = [userLocation distanceFromLocation:siteLocation];
            NSLog(@"The distance to site %@ is %f meters",siteConfiguration.title,distanceToLocation);
            
            if(distanceToLocation > maxDistance){
                maxDistance = distanceToLocation;
                closestSiteConfiguration = siteConfiguration;
            }
    
        
    

    }
    
    
    
    
    return closestSiteConfiguration;
}

    



@end
