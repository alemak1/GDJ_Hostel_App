//
//  NSString+HelperMethods.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/28/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "NSString+HelperMethods.h"

@implementation NSString (HelperMethods)

+ (NSString *)timeFormattedStringFromTotalSeconds:(int)totalSeconds
{
    
    /** int seconds = totalSeconds % 60; **/
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d",hours, minutes];
}

+ (NSString *)timeHHMMSSFormattedStringFromTotalSeconds:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes,seconds];
}


@end
