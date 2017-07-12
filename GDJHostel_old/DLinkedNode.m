//
//  DLinkedNode.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "DLinkedNode.h"

@implementation DLinkedNode


@synthesize nextLinkedNode = _nextLinkedNode;
@synthesize previousLinkedNode = _previousLinkedNode;

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate andWithName:(NSString*)name{
    
    self = [super init];
    
    if(self){
       
        _coordinate = coordinate;
        _name = name;
        _nextLinkedNode = nil;
        _previousLinkedNode = nil;
    }
    
    return self;
}




-(void)setNextLinkedNode:(DLinkedNode*)nextLinkedNode{
    _nextLinkedNode = nextLinkedNode;
}

-(DLinkedNode *)nextLinkedNode{
    return _nextLinkedNode;
}


-(void)setPreviousLinkedNode:(DLinkedNode *)previousLinkedNode{
    _previousLinkedNode = previousLinkedNode;
}

-(DLinkedNode*)previousLinkedNode{
    return _previousLinkedNode;
}

-(CLLocation*)getLocation{
    
    return [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
}


@end
