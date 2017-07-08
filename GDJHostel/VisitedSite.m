//
//  VisitedSite.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "VisitedSite.h"

@implementation VisitedSite


@synthesize regionIdentifier = _regionIdentifier;
@synthesize dateEntered = _dateEntered;
@synthesize  dateExited = _dateExited;


-(instancetype)initWithRegionIdentifier:(NSString*)regionIdentifier andWithDateEntered:(NSDate*)dateEntered{
    
    if(self = [super init]){
        
        self.regionIdentifier = regionIdentifier;
        self.dateEntered = dateEntered;
        
    }
    
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_dateEntered forKey:@"dateEntered"];
    [aCoder encodeObject:_dateExited forKey:@"dateExited"];
    [aCoder encodeObject:_regionIdentifier forKey:@"regionIdentifier"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if(self= [super init]){
        self.dateExited = [aDecoder decodeObjectForKey:@"dateExited"];
        self.dateEntered = [aDecoder decodeObjectForKey:@"dateEntered"];
        self.regionIdentifier = [aDecoder decodeObjectForKey:@"regionIdentifier"];
    }
    
    return self;
}


@end
