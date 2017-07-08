//
//  VisitedSiteCache.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef VisitedSiteCache_h
#define VisitedSiteCache_h

#import <Foundation/Foundation.h>
#import "VisitedSite.h"


@interface VisitedSiteCache : NSObject<NSCoding>



-(void)addVisitedSite:(VisitedSite*)aVisitedSite;
-(NSArray<VisitedSite*>*)getAllVisitedSites;



@end

#endif /* VisitedSiteCache_h */
