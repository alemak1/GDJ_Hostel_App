//
//  HostelInformationController.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/24/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef HostelInformationController_h
#define HostelInformationController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MenuComponent.h"

@interface HostelInformationController : UIViewController

@property (nonatomic, strong) MenuComponent *menuComponent;
@property UIImage* cachedLandscapeImage;
@property UIImage* cachedPortraitImage;

@end

#endif /* HostelInformationController_h */
