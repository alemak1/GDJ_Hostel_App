//
//  NavigationAidEntryController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "NavigationAidEntryController.h"
#import "WarMemorialNavigationController.h"

@implementation NavigationAidEntryController



-(void)viewWillLayoutSubviews{
    
    
    WarMemorialNavigationController* navigationAidController = (WarMemorialNavigationController*)[self.viewControllers firstObject];
    
    navigationAidController.annotationsFileSource = self.annotationsFileSource;
    navigationAidController.annotationViewImagePath = self.annotationViewImagePath;
    navigationAidController.polygonOverlayFileSources = self.polygonOverlayFileSources;
    navigationAidController.mapCoordinateRegion = self.mapCoordinateRegion;
}


-(void)viewDidLoad{
    
}




@end
