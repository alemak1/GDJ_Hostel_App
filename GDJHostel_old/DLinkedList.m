//
//  DLinkedList.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "DLinkedList.h"
#import "AppLocationManager.h"

@interface DLinkedList ()

@property DLinkedNode* rootNode;


@end

@implementation DLinkedList

-(instancetype)initWithFileName:(NSString*)fileName{
    
    self = [super init];
    
    if(self){
        
        NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        
        NSArray* boundaryArray = [NSArray arrayWithContentsOfFile:path];
        
        
        [self createLinkedListWithBoundaryArray:boundaryArray];
        
    }
    
    return self;
}

-(instancetype)initWithFileType2:(NSString*)fileName{
    
    self = [super init];
    
    if(self){
        
        NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        
        NSDictionary* configurationDict = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSArray* boundaryArray = configurationDict[@"boundary"];
        
        [self createLinkedListWithBoundaryArray:boundaryArray];
        
    }
    
    return self;
}




-(void)createLinkedListWithBoundaryArray:(NSArray*)boundaryArray{
    
    NSInteger boundaryPoints = [boundaryArray count];
    
    CLLocationCoordinate2D* temporaryBoundaryArray = calloc(sizeof(CLLocationCoordinate2D), boundaryPoints);
    
    
    
    DLinkedNode* currentNode;
    DLinkedNode* nextNode;
    
    for(int i = 0; i < boundaryPoints; i++){
        
        CGPoint rootPoint = CGPointFromString(boundaryArray[0]);
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(rootPoint.x, rootPoint.y);
        
        temporaryBoundaryArray[i] = coordinate;
        
        /** First initialize the root node and set it equal to its next node **/
        
        if(i == 0){
            currentNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[i] andWithName:[NSString stringWithFormat:@"Node-%d",i]];
            
            nextNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[i+1] andWithName:[NSString stringWithFormat:@"Node-%i",i]];
            
            _rootNode = currentNode;
            
            /** Afer the root node has been initialized, the current node is always the next node down the chain from the rootnode **/
        } else {
            
            
            currentNode = [self getCurrentLastNodeInNextDirection:_rootNode];
            
            /** Once we traverse to the last node, the next node is the roote node, and it's previous node is set to the current node **/
            
            if(i < boundaryPoints-1){
                
                nextNode = [[DLinkedNode alloc] initWithCoordinate:temporaryBoundaryArray[i+1] andWithName:[NSString stringWithFormat:@"Node-%i",i]];
            } else {
                nextNode = _rootNode;
                [_rootNode setPreviousLinkedNode:currentNode];
            }
            
            
        }
        
        [currentNode setNextLinkedNode:nextNode];
        [nextNode setPreviousLinkedNode:currentNode];
        
        
        
    }
    
    
}



-(CLLocationCoordinate2D)getClosestLocationToUser{
    
    CLLocation* userLocation = [[UserLocationManager sharedLocationManager] getLastUpdatedUserLocation];
    
    
    return [self getClosestLocationToLocation:userLocation];
}



-(CLLocationCoordinate2D)getClosestLocationToLocation:(CLLocation*)location{
    

    DLinkedNode* currentNode = _rootNode;
    
    BOOL isClosestNode = NO;
    
    while(!isClosestNode){
        
        
        DLinkedNode* nextNode = [currentNode nextLinkedNode];
        DLinkedNode* previousNode = [currentNode previousLinkedNode];
        
        CLLocation* nextLocation = [nextNode getLocation];
        CLLocation* previousLocation = [previousNode getLocation];
        CLLocation* currentLocation = [currentNode getLocation];
        
        CLLocationDistance distanceToCurrentLoc = [location distanceFromLocation:currentLocation];
        CLLocationDistance distanceToNextLoc = [location distanceFromLocation:nextLocation];
        CLLocationDistance distanceToPreviousLoc = [location distanceFromLocation:previousLocation];
        
        
        if(distanceToCurrentLoc < distanceToNextLoc && distanceToCurrentLoc < distanceToPreviousLoc){
            
            isClosestNode = YES;
        } else {
            
            
            if(distanceToPreviousLoc < distanceToCurrentLoc && distanceToPreviousLoc < distanceToNextLoc){
                currentNode = previousNode;
            }
            
            
            if(distanceToNextLoc < distanceToCurrentLoc && distanceToNextLoc < distanceToPreviousLoc){
                currentNode = nextNode;
            }
            
            
        }
        
    }
    
    return [currentNode coordinate];
    
}





-(void)traverseListWithFunction:(void(^)(DLinkedNode* node))someFunction{
    
    DLinkedNode* currentNode = _rootNode;
    
    someFunction(currentNode);
    
    currentNode = [currentNode nextLinkedNode];
    
    while(currentNode != _rootNode){
        
        someFunction(currentNode);

        currentNode = [currentNode nextLinkedNode];
    }
}

    
-(DLinkedNode*)getCurrentLastNodeInNextDirection:(DLinkedNode*)node{
    
    if(node == nil){
        return nil;
    }
    
    while(node != nil){
        
        node = [node nextLinkedNode];
    }
    
    return node;
    
}


@end
