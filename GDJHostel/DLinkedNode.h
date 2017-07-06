//
//  DLinkedNode.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef DLinkedNode_h
#define DLinkedNode_h

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface DLinkedNode : NSObject

@property CLLocationCoordinate2D coordinate;
@property NSString* name;

@property DLinkedNode* nextLinkedNode;
@property DLinkedNode* previousLinkedNode;


-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate andWithName:(NSString*)name;



@end

#endif /* DLinkedNode_h */
