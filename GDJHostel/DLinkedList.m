//
//  DLinkedList.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "DLinkedList.h"

/**
@implementation DLinkedList

-(instancetype)initWithFileName:(NSString*)fileName{
    
    self = [super init];
    
    if(self){
        
        NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        
        NSArray* boundaryArray = [NSArray arrayWithContentsOfFile:path];
        
        
        NSInteger boundaryPoints = [boundaryArray count];
        
        CLLocationCoordinate2D* temporaryBoundaryArray = calloc(sizeof(CLLocationCoordinate2D), boundaryPoints);

        
        /** Initialize the temporary boundary array with coordinate determined from the array **/

/** 
 
        DLinkedNode* currentNode;
        
        for(int i = 0; i < boundaryPoints; i++){
            
           CGPoint rootPoint = CGPointFromString(boundaryArray[0]);
            
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(rootPoint.x, rootPoint.y);
            
            temporaryBoundaryArray[i] = coordinate;
            /**
            if(i == 0){
                currentNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[i] andWithName:[NSString stringWithFormat:@"Node-%d",i]];
                
                [currentNode setNextLinkedNode: [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[boundaryPoints-1]] andWithName:[NSString stringWithFormat:@"Node-%i",i];
                 
                [currentNode setPreviousLinkedNode:nil];
                
            }
            

        }
        **/
    /**
        
        for(int i = 0; i < boundaryPoints; i++){
            
            
            DLinkedNode* previousNode;
            DLinkedNode* nextNode;
            DLinkedNode* currentNode;
            
            if(i == 0){
                
                currentNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[i] andWithName:[NSString stringWithFormat:@"Node-%i",i]];
                
                _rootNode = currentNode;
                
                 previousNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[boundaryPoints-1] andWithName:[NSString stringWithFormat:@"Node-%i",i]];
                
                 nextNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[i+1] andWithName:[NSString stringWithFormat:@"Node-%i",i]];
                
               
                
            } else if (i == boundaryPoints-1){
                
                currentNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[i] andWithName:[NSString stringWithFormat:@"Node-%i",i]];
                
                
                previousNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[boundaryPoints-1] andWithName:[NSString stringWithFormat:@"Node-%i",i]];
                
                nextNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[i+1] andWithName:[NSString stringWithFormat:@"Node-%i",i]];
                
                
            } else {
               /**
                currentNode = [self getCurrentLastNodeInNextDirection:_rootNode];
                
                previousNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[i-1] andWithName:[NSString stringWithFormat:@"Node-%i",i]];
                
                nextNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[i+1] andWithName:[NSString stringWithFormat:@"Node-%i",i]];
                
                **/
            
            /**
            }
            
            [_rootNode setPreviousLinkedNode:previousNode];
            [_rootNode setNextLinkedNode:nextNode];
            
        }
       
        
        
    }
    
    return self;
}
**/
    
/**
-(CLLocationCoordinate2D)getClosestLocationToUser{
    
}

-(CLLocationCoordinate2D)getFarthestLocationToUser{
    
    
}
**/

    /**
-(DLinkedNode*)getCurrentLastNodeInNextDirection:(DLinkedNode*)node{
    
    if(node == nil){
        return nil;
    }
    
    while(node != nil){
        
        node = [node nextLinkedNode];
    }
    
    return node;
    
}
**/

//@end
