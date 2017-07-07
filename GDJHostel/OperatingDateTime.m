//
//  OperatingDateTime.m/Users/yongrenwang/Desktop/GDJHostel/GDJHostel.xcodeproj
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "OperatingDateTime.h"


@interface OperatingDateTime ()

@property (atomic) NSInteger startingOperatingMonth;
@property (atomic) NSInteger startingOperatingDay;

@property (atomic) NSInteger endingOperatingMonth;
@property (atomic) NSInteger endingOperatingDay;


@property NSRange* weekdayOperatingHours;


@end

/** The OperatingDateTime object maps a weekday number (i.e. 1-7, where 1 is Sunday) to an NSRange object that holds the time interval for the tourist site's operating time in seconds **/

@implementation OperatingDateTime


@synthesize startingOperatingDay = _startingOperatingDay;
@synthesize startingOperatingMonth = _startingOperatingMonth;
@synthesize endingOperatingDay = _endingOperatingDay;
@synthesize endingOperatingMonth = _endingOperatingMonth;





-(instancetype)initWithStartingMonth:(NSInteger)startingMonth andWithStartingDay:(NSInteger)startingDay andWithEndingMonth:(NSInteger)endingMonth andWithEndingDay:(NSInteger)endingDay andWithOperatingHoursDictionary:(NSDictionary*)operatingHoursDictionary{
    
    
    self = [super init];
    
    if(self){
        
        _startingOperatingMonth = startingMonth;
        _startingOperatingDay = startingDay;
        _endingOperatingMonth = endingMonth;
        _endingOperatingDay = endingDay;
        
        
        /** By default, each day**/
        
        NSLog(@"Allocating memory for array of NSRange structs");
        
        _weekdayOperatingHours = calloc(sizeof(NSRange), 7);
        
        NSLog(@"Preparing to perform array initialization...");

        for(int i = 0; i < 7; i++){
            
            WEEKDAY weekDay = (WEEKDAY)i;
            
            NSString* operatingRangeString;
            
            switch (weekDay) {
                case WKDAY_SUNDAY:
                    operatingRangeString = [operatingHoursDictionary valueForKey:@"sundayOperatingRange"];
                    NSLog(@"OperatingRangeString for Sunday: %@",operatingRangeString);
                    break;
                case WKDAY_MONDAY:
                    operatingRangeString = [operatingHoursDictionary valueForKey:@"mondayOperatingRange"];
                     NSLog(@"OperatingRangeString for Monday: %@",operatingRangeString);
                    break;
                case WKDAY_TUESDAY:
                    operatingRangeString = [operatingHoursDictionary valueForKey:@"tuesdayOperatingRange"];
                     NSLog(@"OperatingRangeString for Tuesday: %@",operatingRangeString);
                    break;
                case WKDAY_WEDNESDAY:
                   operatingRangeString = [operatingHoursDictionary valueForKey:@"wednesdayOperatingRange"];
                     NSLog(@"OperatingRangeString for Wednesday: %@",operatingRangeString);
                    break;
                case WKDAY_THURSDAY:
                    operatingRangeString = [operatingHoursDictionary valueForKey:@"thursdayOperatingRange"];
                     NSLog(@"OperatingRangeString for Thursday: %@",operatingRangeString);
                    break;
                case WKDAY_FRIDAY:
                    operatingRangeString = [operatingHoursDictionary valueForKey:@"fridayOperatingRange"];
                     NSLog(@"OperatingRangeString for Friday: %@",operatingRangeString);
                    break;
                case WKDAY_SATURDAY:
                    operatingRangeString = [operatingHoursDictionary valueForKey:@"saturdayOperatingRange"];
                     NSLog(@"OperatingRangeString for Saturday: %@",operatingRangeString);
                    break;
                default:
                    break;
            }
            
            NSRange operatingRange = NSRangeFromString(operatingRangeString);
            
            _weekdayOperatingHours[i] = operatingRange;
            
            NSLog(@"For given day, the range location is %d, and the length is %d", _weekdayOperatingHours[i].location, _weekdayOperatingHours[i].length);
            
            NSLog(@"Finished loading array with operaing hour ranges for each integer day");

            
        }
         
        
    }
    
    return self;
    
}

-(NSInteger)openingTimeInSeconds:(double)openingTime{
    
    return openingTime*60*60;
}

-(NSInteger)operatingIntervalInSecondsFromOpeningTime:(double)openingTime andClosingTime:(double)closingTime{
    
    NSInteger openingTimeInSeconds = openingTime*60*60;
    NSInteger closingTimeInSeconds = closingTime*60*60;
    
    return closingTimeInSeconds - openingTimeInSeconds;
    
}


-(NSInteger)timeUntilClosingInSeconds:(NSDate*)date{
    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents* components = [gregorian components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    
    NSInteger secondsFromHour = [components hour]*3600;
    NSInteger secondsFromMinute = [components minute]*60;
    NSInteger seconds = [components second];
    NSInteger timeOfDateInSeconds = secondsFromHour + secondsFromMinute + seconds;
    
    
    WEEKDAY weekday = (WEEKDAY)([components weekday] - 1);
    
    NSRange operatingRange = self.weekdayOperatingHours[weekday];
    
    return operatingRange.length - (timeOfDateInSeconds - operatingRange.location);
    
}

-(NSInteger)timeUntilOpeningInSeconds:(NSDate*)date{
    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents* components = [gregorian components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    
    NSInteger secondsFromHour = [components hour]*3600;
    NSInteger secondsFromMinute = [components minute]*60;
    NSInteger seconds = [components second];
    NSInteger timeOfDateInSeconds = secondsFromHour + secondsFromMinute + seconds;
    
    
    WEEKDAY weekday = (WEEKDAY)([components weekday] - 1);
    
    NSRange operatingRange = self.weekdayOperatingHours[weekday];
    
    return operatingRange.length - (timeOfDateInSeconds - operatingRange.location);
    
}
 



-(BOOL)isWithinOperatingHourRange:(NSDate*)date{
    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents* components = [gregorian components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    
    NSInteger secondsFromHour = [components hour]*3600;
    NSInteger secondsFromMinute = [components minute]*60;
    NSInteger seconds = [components second];
    NSInteger timeOfDateInSeconds = secondsFromHour + secondsFromMinute + seconds;
    
    
    WEEKDAY weekday = (WEEKDAY)([components weekday] - 1);
    
    NSRange operatingRange = self.weekdayOperatingHours[weekday];
    
    return (timeOfDateInSeconds - operatingRange.location) <= operatingRange.length;
}




-(BOOL)isWithinOperatingDayRange:(NSDate*)date{
    
    
    
    /** If either starting or ending operating month is less than zero, then the tourist site is open year-round **/
    
    if(self.startingOperatingMonth <= 0 || self.endingOperatingMonth <= 0){
        return YES;
    }
    
    
    /** The date provided by the user is broken into month, day, and year components **/
    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger calendarUnits = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents* components = [gregorian components:calendarUnits fromDate:date];

    NSUInteger yearForUserDate = [components year];
    
    
    /** The year for the user-provided date is used as a reference year for a date object initialized with startingOperatingMonth and startingOperatingDay **/
    
    NSDateComponents* startingDateComponents = [[NSDateComponents alloc] init];
    
    [startingDateComponents setYear:yearForUserDate];
    [startingDateComponents setMonth:self.startingOperatingMonth];
    [startingDateComponents setDay:self.startingOperatingDay];
    
    NSDate* startingDate = [gregorian dateFromComponents:startingDateComponents];
    
    /** The year for the user-provided date is used as a reference year for a date object initialized with endingOperatingMonth and endingOperatingDay **/

    
    NSDateComponents* endingDateComponents = [[NSDateComponents alloc] init];
    
    [endingDateComponents setYear:yearForUserDate];
    [endingDateComponents setMonth:self.endingOperatingMonth];
    [endingDateComponents setDay:self.endingOperatingDay];
    
    NSDate* endingDate = [gregorian dateFromComponents:endingDateComponents];
    
    
    /** The user-provided date is compared to the endingDate and startingDate constructed fro the user date's year and pre-specified values for the openign month/day and closing month/day **/
    
    if([date compare:endingDate] == NSOrderedDescending){
        return NO;
    }
    
    if([date compare:startingDate] == NSOrderedAscending){
        return NO;
    }
    
    
    return YES;
}




/** Assumes the Korean New Year falls on the same date as the Chiense New Year; this assumption is generally true, but once in a while a 1-day discrepancy occurs **/
+(NSDate*)seoullalDateForGregorianYear:(NSUInteger)gregorianYear{
    
    /** Obtain a date from an NSCalendar object initialized with the Korean calendar and whose month and day components are specified as the 1st month and 1st day, respectively;  Gregorian-equivalent components are obtained from NSCalendar initialzied with the Gregorian calendar and with the date obtained for the Korean New Year **/
    

    NSDate* gregorianDateForKoreanNewYear = [OperatingDateTime getGregorianDateForGregorianYear:gregorianYear andForLunarMonth:1 andLunarDay:1];
    
    return gregorianDateForKoreanNewYear;
}


+(NSDate*)chuseokDateForGregorianYear:(NSUInteger)gregorianYear{
    
   
    
    NSDate* gregorianDateForKoreanChuseok = [OperatingDateTime getGregorianDateForGregorianYear:gregorianYear andForLunarMonth:8 andLunarDay:15];
    
    return gregorianDateForKoreanChuseok;
}


+ (NSDate*)getGregorianDateForGregorianYear:(NSUInteger)gregorianYear andForLunarMonth:(NSUInteger)lunarMonth andLunarDay:(NSUInteger)lunarDay{
    
    NSCalendar* koreanCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSDateComponents* componentsKorean = [[NSDateComponents alloc] init];
    [componentsKorean setDay:lunarDay];
    [componentsKorean setMonth:lunarMonth];
    
    NSDate* koreanCalendarDate = [koreanCalendar dateFromComponents:componentsKorean];
    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger calendarUnits = NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth;
    
    NSDateComponents* gregorianComponents = [gregorian components:calendarUnits fromDate:koreanCalendarDate];
    
    return [gregorian dateFromComponents:gregorianComponents];
}

@end
