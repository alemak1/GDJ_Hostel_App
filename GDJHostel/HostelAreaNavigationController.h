//
//  HostelAreaNavigationController.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef HostelAreaNavigationController_h
#define HostelAreaNavigationController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HostelAreaNavigationController : UINavigationController

@property MKCoordinateRegion mapRegion;
@property NSString* annotationSourceFilePath;



@end

#endif /* HostelAreaNavigationController_h */
