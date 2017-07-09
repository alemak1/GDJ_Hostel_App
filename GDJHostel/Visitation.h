//
//  Visitation.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef Visitation_h
#define Visitation_h


#import <Foundation/Foundation.h>


@interface Visitation : NSObject

-(instancetype)initWithRegionIdentifier:(NSString*)regionIdentifier;

-(instancetype)initWithRegionIdentifier:(NSString*)regionIdentifier andWithTimeEntered:(NSDate*)timeEntered;


-(void)setExitTime:(NSDate*)timeExited;
-(NSString*)visitationTimeString;


@end

#endif /* Visitation_h */
