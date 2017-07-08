//
//  VisitedSite.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef VisitedSite_h
#define VisitedSite_h

#import <Foundation/Foundation.h>

@interface VisitedSite : NSObject<NSCoding>


@property NSString* regionIdentifier;
@property NSDate* dateEntered;
@property NSDate* dateExited;

@property (readonly) NSDateComponents* visitDuration;


-(instancetype)initWithRegionIdentifier:(NSString*)regionIdentifier andWithDateEntered:(NSDate*)dateEntered;




@end

#endif /* VisitedSite_h */
