//
//  HostelAreaNavigationController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "HostelAreaNavigationController.h"
#import "HostelAreaContainerController.h"


@implementation HostelAreaNavigationController

-(void)viewWillLayoutSubviews{
    
    HostelAreaContainerController* containerController = (HostelAreaContainerController*)[self.viewControllers firstObject];
    
    containerController.annotationSourceFilePath = self.annotationSourceFilePath;
    containerController.mapRegion = self.mapRegion;
    
}


-(void)viewDidLoad{
    
}


@end
