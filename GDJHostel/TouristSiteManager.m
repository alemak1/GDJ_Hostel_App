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


@property NSMutableArray<TouristSiteConfiguration*>* configurationArray;


@end

@implementation TouristSiteManager

NSArray* _touristSiteDictArray;


-(instancetype)initWithFileName:(NSString*)fileName{
    
    self = [super init];
    
    if(self){
        NSString* path = [[NSBundle mainBundle] pathForResource:@"SeoulTouristSites" ofType:@"plist"];
    
        _touristSiteDictArray = [NSArray arrayWithContentsOfFile:path];
    
        NSLog(@"Tourist Dite Dict Array: %@", [_touristSiteDictArray description]);
        
        for(NSDictionary* dict in _touristSiteDictArray){
            TouristSiteConfiguration* touristSiteConfiguration = [[TouristSiteConfiguration alloc] initWithConfigurationDict:dict];
        
            [_configurationArray addObject:touristSiteConfiguration];
        }
    
    }
    
    NSLog(@"Configuration Array: %@",_configurationArray);
    
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


@end
