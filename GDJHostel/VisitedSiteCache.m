//
//  VisitedSiteCache.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "VisitedSiteCache.h"
#import "VisitedSite.h"

@interface VisitedSiteCache () <NSCoding>


@property NSMutableArray<VisitedSite*>* visitedSiteCache;


@end


@implementation VisitedSiteCache


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super init]){
        
        if(self.visitedSiteCache == nil){
            self.visitedSiteCache = [[NSMutableArray<VisitedSite*> alloc] init];
        }
        
        [aDecoder decodeObjectForKey:@"visitedSiteCache"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.visitedSiteCache forKey:@"visitedSiteCache"];
}


-(void)addVisitedSite:(VisitedSite*)aVisitedSite{
    
    [self.visitedSiteCache addObject:aVisitedSite];
}

-(NSArray<VisitedSite*>*)getAllVisitedSites{
    return [NSArray arrayWithArray:self.visitedSiteCache];
}

@end
