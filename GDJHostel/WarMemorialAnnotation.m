//
//  WarMemorialAnnotation.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "WarMemorialAnnotation.h"

@implementation WarMemorialAnnotation

-(instancetype)initWithDict:(NSDictionary*)configurationDict{
    
    self = [super init];
    
    if(self){
        
        self.title = configurationDict[@"title"];
        self.subtitle = configurationDict[@"subtitle"];
        self.annotationDescription = configurationDict[@"description"];
        self.imagePath =  configurationDict[@"imagePath"];
        
        NSString* coordinateString = configurationDict[@"coordinate"];
        CGPoint point = CGPointFromString(coordinateString);
        
        self.coordinate = CLLocationCoordinate2DMake(point.x, point.y);



    }
    
    return self;
}

@end
