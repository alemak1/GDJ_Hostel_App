//
//  VisitationPeriod.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "VisitationPeriod.h"

@interface VisitationPeriod () <NSCoding>

@end



@implementation VisitationPeriod

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.dateEntered forKey:@"dateEntered"];
    [aCoder encodeObject:self.dateExited forKey:@"dateExited"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super init]){
        
        self.dateExited = [aDecoder decodeObjectForKey:@"dateExited"];
        self.dateEntered = [aDecoder decodeObjectForKey:@"dateEntered"];
        
    }
    
    return self;
}

@end
