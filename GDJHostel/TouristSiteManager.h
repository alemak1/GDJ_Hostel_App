//
//  TouristSiteManager.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef TouristSiteManager_h
#define TouristSiteManager_h

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "TouristSiteConfiguration.h"

@interface TouristSiteManager : NSObject

@property NSArray<TouristSiteConfiguration *>* touristSites;

@end

#endif /* TouristSiteManager_h */
