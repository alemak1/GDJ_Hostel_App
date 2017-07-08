//
//  FlickrSearchResults.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrSearchResults.h"

@implementation FlickSearchResults

-(instancetype)initWithSearchTerm:(NSString*)searchTerm andWithSearchResults:(NSMutableArray*)searchResults{
    
    if(self = [super init]){
        
        self.searchTerm = searchTerm;
        self.searchResults = searchResults;
    }
    
    return self;
    
    
}


-(instancetype)init{
    
    if(self = [super init]){
        
        self.searchTerm = [[NSString alloc] init];
        self.searchResults = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
