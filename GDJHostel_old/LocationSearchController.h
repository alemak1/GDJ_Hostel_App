//
//  LocationSearchController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef LocationSearchController_h
#define LocationSearchController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationSearchController : UIViewController<MKMapViewDelegate,UISearchBarDelegate>

- (IBAction)dismissViewController:(id)sender;

- (IBAction)getDirectionsInMaps:(UIButton *)sender;

@end

#endif /* LocationSearchController_h */
