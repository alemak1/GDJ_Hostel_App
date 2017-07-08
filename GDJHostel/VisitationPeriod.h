//
//  VisitationPeriod.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef VisitationPeriod_h
#define VisitationPeriod_h


#import <Foundation/Foundation.h>

@interface VisitationPeriod : NSObject

@property NSDate* dateEntered;
@property NSDate* dateExited;
@property (readonly) NSDateComponents* visitationDuration;

@end

#endif /* VisitationPeriod_h */
