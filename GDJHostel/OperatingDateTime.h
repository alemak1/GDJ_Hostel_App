//
//  OperatingDateTime.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef OperatingDateTime_h
#define OperatingDateTime_h

#import <Foundation/Foundation.h>

/** OperatingDateTime object encapsulates information for months, days, weekdays,and hours for which a tourist site is operating and open **/

@interface OperatingDateTime : NSObject


typedef enum WEEKDAY{
    WKDAY_SUNDAY = 0,
    WKDAY_MONDAY,
    WKDAY_TUESDAY,
    WKDAY_WEDNESDAY,
    WKDAY_THURSDAY,
    WKDAY_FRIDAY,
    WKDAY_SATURDAY
}WEEKDAY;

/** If operating hours become complicated such that a given site may be opened at separate, non-overlapping intervals for a given year, then use an array to contain the several OperatingDateTime objects **/



-(instancetype)initWithStartingMonth:(NSInteger)startingMonth andWithStartingDay:(NSInteger)startingDay andWithEndingMonth:(NSInteger)endingMonth andWithEndingDay:(NSInteger)endingDay andWithOperatingHoursDictionary:(NSDictionary*)operatingHoursDictionary;


-(BOOL)isWithinOperatingDayRange:(NSDate*)date;

-(BOOL)isWithinOperatingHourRange:(NSDate*)date;

-(NSInteger)timeUntilClosingInSeconds:(NSDate*)date;


+(NSDate*)seoullalDateForGregorianYear:(NSUInteger)gregorianYear;

+(NSDate*)chuseokDateForGregorianYear:(NSUInteger)gregorianYear;



@end

#endif /* OperatingDateTime_h */
