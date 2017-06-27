//
//  TouristSiteConfiguration.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristSiteConfiguration.h"

@implementation TouristSiteConfiguration

/**
@synthesize midCoordinate = _midCoordinate;
@synthesize overlayBottomLeftCoordinate = _overlayBottomLeftCoordinate;
@synthesize overlayBottomRightCoordinate = _overlayBottomRightCoordinate;
@synthesize overlayTopLeftCoordinate = _overlayTopLeftCoordinate;
@synthesize overlayTopRightCoordinate = _overlayTopRightCoordinate;
@synthesize overlayBoundingMapRect = _overlayBoundingMapRect;
@synthesize boundaryPointsCount = _boundaryPointsCount;
@synthesize boundary = _boundary;
**/

NSUInteger _numberOfDaysClosed = 0;

/** Tourist Objects can also be initialized from file directly, with the initializer implementation overriding that of the base class **/

- (instancetype)initWithFilename:(NSString *)filename{
    
    self = [super initWithFilename:filename];
    
    if(self){
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
        NSDictionary *configurationDictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        _title = [configurationDictionary valueForKey:@"title"];
        _siteDescription = [configurationDictionary valueForKey:@"description"];
        _admissionFee = [[configurationDictionary valueForKey:@"admissionFee"] doubleValue];
        _touristSiteCategory = (int)[[configurationDictionary valueForKey:@"category"] integerValue];
        _imagePath = [configurationDictionary valueForKey:@"imagePath"];
        
        _openingTime = [configurationDictionary valueForKey:@"openingTime"];
        _closingTime = [configurationDictionary valueForKey:@"closingTime"];
        
        _physicalAddress = [configurationDictionary valueForKey:@"physicalAddress"];
        _webAddress = [configurationDictionary valueForKey:@"webAddress"];
        _specialNote = [configurationDictionary valueForKey:@"specialNote"];
        
        
        
        NSArray* daysClosedArray = [configurationDictionary valueForKey:@"daysClosed"];
        NSLog(@"Days Closed Array: %@",[daysClosedArray description]);
        
        _numberOfDaysClosed = [daysClosedArray count];
        
        _daysClosed = calloc(sizeof(int), _numberOfDaysClosed);
        
        for(int i = 0; i < _numberOfDaysClosed; i++){
            NSLog(@"Value from daysClosedArray",[daysClosedArray[i] integerValue]);
            _daysClosed[i] = [daysClosedArray[i] integerValue];
            NSLog(@"%@ is closed on: %d",_title,_daysClosed[i]);
        }
        
    }
    
    return self;
}

/** Since the TouristSiteManager is initialized from a plist file containing an array of dictionaries, each configuration object can be initialized with dictionary in order to facilitiate the initialization of the Tourist Object manager class **/

-(instancetype)initWithConfigurationDict:(NSDictionary*)configurationDictionary{
    
    self = [super initWithDictionary:configurationDictionary];
    
    if(self){
        
        _title = [configurationDictionary valueForKey:@"title"];
        _siteDescription = [configurationDictionary valueForKey:@"description"];
        _admissionFee = [[configurationDictionary valueForKey:@"admissionFee"] doubleValue];
        _touristSiteCategory = (int)[[configurationDictionary valueForKey:@"category"] integerValue];

        _openingTime = [configurationDictionary valueForKey:@"openingTime"];
        _closingTime = [configurationDictionary valueForKey:@"closingTime"];
        
        _physicalAddress = [configurationDictionary valueForKey:@"physicalAddress"];
        _webAddress = [configurationDictionary valueForKey:@"webAddress"];
        _specialNote = [configurationDictionary valueForKey:@"specialNote"];
        _imagePath = [configurationDictionary valueForKey:@"imagePath"];

        
        
        NSArray* daysClosedArray = [configurationDictionary valueForKey:@"daysClosed"];
        _numberOfDaysClosed = [daysClosedArray count];
        
        _daysClosed = calloc(sizeof(int), _numberOfDaysClosed);
        
        for(int i = 0; i < _numberOfDaysClosed; i++){
            _daysClosed[i] = [daysClosedArray[i] integerValue];
            
        }
       
    
    }
    
    
    return self;
    
}


-(NSString*)debugDescriptionA{
    return [NSString stringWithFormat:@"Tourist Site Title: %@; Name: %@; Description: %@",self.title,self.name,self.siteDescription];
}

-(NSString*)debugDescriptionB{
     NSString* rawString = [NSString stringWithFormat:@"Tourist Site Title: %@; Name: %@; Description: %@; Opens at %f, Closes at %f, Category: %@",self.title,self.name,self.siteDescription,[self.openingTime doubleValue],[self.closingTime doubleValue],[self stringForTouristSiteCategory:self.touristSiteCategory]];
    
    rawString = [rawString stringByAppendingString:@" Closed on the following days: "];
    
    for(int i = 0; i < _numberOfDaysClosed; i++){
        NSString* dayClosed = [self stringForDayOfWeek:_daysClosed[i]];
    
        rawString = [rawString stringByAppendingString:[NSString stringWithFormat:@"%@, ", dayClosed]];
    }
    
    return rawString;
}


- (NSString*) stringForDayOfWeek:(DayOfWeek)day{
    switch (day) {
        case MONDAY:
            return @"Monday";
        case TUESDAY:
            return @"Tuesday";
        case WEDNESDAY:
            return @"Wednesday";
        case THURSDAY:
            return @"Thursday";
        case FRIDAY:
            return @"Friday";
        case SATURDAY:
            return @"Saturday";
        case SUNDAY:
            return @"Sunday";
    }
}


- (NSString*) stringForTouristSiteCategory:(TouristSiteCategory)touristSiteCategory{
    
    NSString* stringCategory;
    
    switch (touristSiteCategory) {
        case MONUMENT_OR_WAR_MEMORIAL:
            stringCategory = @"Monument/Memorial";
            break;
        case RADIO_TOWER:
            stringCategory = @"Radio Tower";
            break;
        case SHOPPING_AREA:
            stringCategory = @"Shopping Area";
            break;
        case NATURAL_SITE:
            stringCategory = @"Natural Site";
            break;
        case NIGHT_MARKET:
            stringCategory = @"Night Market";
            break;
        case MUSUEM:
            stringCategory = @"Museum";
            break;
        case TEMPLE:
            stringCategory = @"Temple";
            break;
        case PARK:
            stringCategory = @"Park";
            break;
        default:
            break;
    }
    
    return stringCategory;
}

/**
-(BOOL)isOpen{
    //TODO: get current time, match against opening/closing hours
}

-(NSDate *)timeUntilClosing{
    
    if(!self.isOpen){
        return nil;
    }
    
    //TODO: get current time, calculate difference between closing time and current time
}


-(NSDate *)timeUntilOpening{
    
    if(self.isOpen){
        return nil;
    }
    
    //TODO: get current time, calculate difference between opening and current time
}


-(CGFloat)distanceFromUser{
    //TODO: get user's current location to calculate the distance to the site
}

-(CGFloat)travelingTimeFromUserLocation{
    //TODO: get the user's current location to calculate the distance to the site
}


**/

@end
