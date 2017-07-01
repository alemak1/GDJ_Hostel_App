//
//  BikingRoutesController.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef BikingRoutesController_h
#define BikingRoutesController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BikingRoutesController : UITableViewController


typedef enum BIKE_ROUTES{
    GONGDEOK_HYOCHANG_ROUTE,
    GONGDEOK_SEOGANG_ROUTE,
    LAST_ROUTE_INDEX
}BIKE_ROUTES;

@end

#endif /* BikingRoutesController_h */
