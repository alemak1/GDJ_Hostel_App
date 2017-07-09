//
//  NavigationAidEntryController.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef NavigationAidEntryController_h
#define NavigationAidEntryController_h

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface NavigationAidEntryController : UINavigationController

@property NSString* annotationsFileSource;
@property NSArray<NSString*>* polygonOverlayFileSources;
@property MKCoordinateRegion mapCoordinateRegion;
@property NSString* annotationViewImagePath;


@end

#endif /* NavigationAidEntryController_h */
