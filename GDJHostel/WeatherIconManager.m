//
//  WeatherIconManager.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/29/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherIconManager.h"


NSString* const kHAIL = @"hail";
NSString* const kRAIN = @"rain";
NSString* const kSNOW = @"snow";
NSString* const kSLEET = @"sleet";
NSString* const kWINDY = @"wind";
NSString* const kCLOUDY = @"cloudy";
NSString* const kPARTLY_CLOUDY_DAY = @"partly-cloudy-day";
NSString* const kPARTLY_CLOUDY_NIGHT = @"partly-cloudy-night";
NSString* const kCLEAR_DAY = @"clear-day";
NSString* const kCLEAR_NIGHT = @"clear-night";
NSString* const kFOG = @"fog";



@interface WeatherIconManager ()

+(NSDictionary*) weatherIconDict;

@end

@implementation WeatherIconManager

static NSDictionary* _weatherIconDict;

+(UIImage*) getWeatherIconForFilePath:(NSString*)filePath{
    
    return [[WeatherIconManager weatherIconDict] valueForKey:filePath];
}

+(UIImage*)getWeatherIconForWeatherCategoryEnum:(WeatherCategory)weatherCategory{
    NSString* filePath = [WeatherIconManager getWeatherIconKeyForWeatherCategoryEnum:weatherCategory];
    
    return [WeatherIconManager getWeatherIconForFilePath:filePath];
}

+(NSDictionary *)weatherIconDict{
    
    if(!_weatherIconDict){
        _weatherIconDict = [NSDictionary dictionaryWithObjectsAndKeys:
            [UIImage imageNamed:@"rainB"],kRAIN,
            [UIImage imageNamed:@"snowB"],kSNOW,
            [UIImage imageNamed:@"sleetB"],kSLEET,
            [UIImage imageNamed:@"hailB"],kHAIL,
            [UIImage imageNamed:@"partlyCloudyDayB"],kPARTLY_CLOUDY_DAY,
            [UIImage imageNamed:@"partlyCloudyNightB"],kPARTLY_CLOUDY_NIGHT,
            [UIImage imageNamed:@"cloudyB"],kCLOUDY,
            [UIImage imageNamed:@"windB"],kWINDY,
            [UIImage imageNamed:@"clearB"],kCLEAR_DAY,
            [UIImage imageNamed:@"clearNightB"],kCLEAR_NIGHT,
            [UIImage imageNamed:@"fogB"],kFOG,
            [UIImage imageNamed:@"clearNightB"],kCLEAR_NIGHT, nil];
    }
    
    return _weatherIconDict;
}




+(NSString*) getWeatherIconKeyForWeatherCategoryEnum:(WeatherCategory)weatherCategory{
    switch (weatherCategory) {
        case SNOW:
            return kSNOW;
        case RAIN:
            return kRAIN;
        case PARTLY_CLOUDY_DAY:
            return kPARTLY_CLOUDY_DAY;
        case PARTLY_CLOUDY_NIGHT:
            return kPARTLY_CLOUDY_NIGHT;
        case CLEAR_DAY:
            return kCLEAR_DAY;
        case CLEAR_NIGHT:
            return kCLEAR_NIGHT;
        case CLOUDY:
            return kCLOUDY;
        case SLEET:
            return kSLEET;
        case HAIL:
            return kHAIL;
        case FOG:
            return kFOG;
        case WIND:
            return kWINDY;
        default:
            return nil;
    }
}


@end
