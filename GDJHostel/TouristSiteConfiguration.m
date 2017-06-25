//
//  TouristSiteConfiguration.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristSiteConfiguration.h"

@implementation TouristSiteConfiguration


/** Tourist Objects can also be initialized from file directly, with the initializer implementation overriding that of the base class **/

- (instancetype)initWithFilename:(NSString *)filename{
    
    self = [NSObject init];
    
    if(self){
        
        
    }
    
    return self;
}

/** Since the TouristSiteManager is initialized from a plist file containing an array of dictionaries, each configuration object can be initialized with dictionary in order to facilitiate the initialization of the Tourist Object manager class **/

-(instancetype)initWithConfigurationDict:(NSDictionary*)configurationDictionary{
    
    self = [NSObject init];
    
    if(self){
        
    }
    
    return self;
    
}


@end
