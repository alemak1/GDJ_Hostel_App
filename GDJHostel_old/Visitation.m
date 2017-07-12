//
//  Visitation.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "Visitation.h"
#import "NSString+HelperMethods.h"

@interface Visitation () <NSCoding>

@property NSString* regionIdentifier;
@property NSDate* timeEntered;
@property NSDate* timeExited;
@property BOOL hasExited;

@end


@implementation Visitation



-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super init]){
        _regionIdentifier = [aDecoder decodeObjectForKey:@"regionIdentifier"];
        _hasExited = [[aDecoder decodeObjectForKey:@"hasExited"] boolValue];
        _timeExited = [aDecoder decodeObjectForKey:@"timeExited"];
        _timeEntered = [aDecoder decodeObjectForKey:@"timeEntered"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.regionIdentifier forKey:@"regionIdentifier"];
    [aCoder encodeObject:self.timeEntered forKey:@"timeEntered"];
    [aCoder encodeObject:self.timeExited forKey:@"timeExited"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.hasExited] forKey:@"hasExited"];
}



-(instancetype)initWithRegionIdentifier:(NSString*)regionIdentifier{
    
    if(self = [super init]){
        _regionIdentifier = regionIdentifier;
        _timeEntered = [NSDate date];
        _hasExited = false;
    }
    
    return self;
}

-(instancetype)initWithRegionIdentifier:(NSString*)regionIdentifier andWithTimeEntered:(NSDate*)timeEntered{
    
    if(self = [super init]){
        _regionIdentifier = regionIdentifier;
        _timeEntered = timeEntered;
        _hasExited = false;
    }
    
    return self;
}


-(void)setExitTime:(NSDate*)timeExited{
    
    if(!_hasExited){
        _timeExited = timeExited;
        _hasExited = true;
    }
}

-(NSDateComponents*)visitationTime{
    
    if(!_hasExited){
        return nil;
    }
    
    NSCalendar* gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    return [gregorian components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:self.timeEntered toDate:self.timeExited options:0];

}

-(NSString*)visitationTimeString{
    
    if(!_hasExited){
        return nil;
    }
    
    NSDateComponents* dateComponents = [self visitationTime];
    
    NSInteger hours = [dateComponents hour];
    NSInteger minutes = [dateComponents minute];
    NSInteger seconds = [dateComponents second];
    
    
    NSString* visitationTimeString = @"Time at Site: ";
    
    if(hours > 0){
        visitationTimeString = [visitationTimeString stringByAppendingString:[NSString stringWithFormat:@"Hours: %ld",(long)hours]];
    }
    
    if(minutes > 0){
         visitationTimeString = [visitationTimeString stringByAppendingString:[NSString stringWithFormat:@"Minutes: %ld",(long)minutes]];
    }
    
    if(seconds > 0){
        
         visitationTimeString = [visitationTimeString stringByAppendingString:[NSString stringWithFormat:@"Seconds: %ld",(long)seconds]];
        
    }
    
    
    return visitationTimeString;
}




@end
