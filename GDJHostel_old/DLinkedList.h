//
//  DLinkedList.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef DLinkedList_h
#define DLinkedList_h

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DLinkedNode.h"


@interface DLinkedList : NSObject


-(instancetype)initWithFileType2:(NSString*)fileName;

-(CLLocationCoordinate2D)getClosestLocationToUser;

-(void)traverseListWithFunction:(void(^)(DLinkedNode* node))someFunction;


@end

#endif /* DLinkedList_h */
