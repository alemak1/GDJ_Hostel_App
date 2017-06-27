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

@interface TouristSiteManager ()


@property NSMutableArray* configurationArray;


@end

@implementation TouristSiteManager

NSArray* _touristSiteDictArray;


-(instancetype)initWithFileName:(NSString*)fileName{
    
    self = [super init];
    
    if(self){
        NSString* path = [[NSBundle mainBundle] pathForResource:@"SeoulTouristSites" ofType:@"plist"];
    
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

//TODO: Use the predicate syntax to get arrays derived from the original set of tourist configuraiton objects

- (NSMutableArray<TouristSiteConfiguration*>*)getArrayForTouristSiteCategory:(TouristSiteCategory)touristSiteCategory{
    
    NSPredicate* categoryPredicate = [NSPredicate predicateWithFormat:@"SELF"];
    
    NSMutableArray* copiedArray = [self.configurationArray copy];
    
    [copiedArray filterUsingPredicate:categoryPredicate];
    
    return copiedArray;
    
}


- (NSMutableArray<TouristSiteConfiguration*>*)getArrayForMaximumTravelingTime:(CGFloat)maxTravelingTime{
    
    NSPredicate* categoryPredicate = [NSPredicate predicateWithFormat:@"SELF"];
    
    NSMutableArray* copiedArray = [self.configurationArray copy];
    
    [copiedArray filterUsingPredicate:categoryPredicate];
    
    return copiedArray;
    
}

- (NSMutableArray<TouristSiteConfiguration*>*)getArrayForMinimumDistanceFromUser:(CGFloat)minimumDistance{
    
    NSPredicate* categoryPredicate = [NSPredicate predicateWithFormat:@"SELF"];
    
    NSMutableArray* copiedArray = [self.configurationArray copy];
    
    [copiedArray filterUsingPredicate:categoryPredicate];
    
    return copiedArray;
    
}

- (NSMutableArray<TouristSiteConfiguration*>*)getArrayForAdmissionFee:(CGFloat)admissionFee{
    
    NSPredicate* categoryPredicate = [NSPredicate predicateWithFormat:@"SELF"];
    
    NSMutableArray* copiedArray = [self.configurationArray copy];
    
    [copiedArray filterUsingPredicate:categoryPredicate];
    
    return copiedArray;
    
}

- (NSMutableArray<TouristSiteConfiguration*>*)getArrayForCurrentlyOpenSites{
    
    NSPredicate* categoryPredicate = [NSPredicate predicateWithFormat:@"SELF"];
    
    NSMutableArray* copiedArray = [self.configurationArray copy];
    
    [copiedArray filterUsingPredicate:categoryPredicate];
    
    return copiedArray;
    
}




@end
