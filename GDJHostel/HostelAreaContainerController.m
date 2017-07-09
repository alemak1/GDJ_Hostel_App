//
//  HostelAreaContainerController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "HostelAreaContainerController.h"
#import "HostelAreaMapViewController.h"

@interface HostelAreaContainerController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation HostelAreaContainerController

-(void)viewWillLayoutSubviews{
    
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    HostelAreaMapViewController* hostelAreaMapViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"HostelAreaAnnotationSurveyController"];
    
    hostelAreaMapViewController.annotationSourceFilePath = self.annotationSourceFilePath;
    
    hostelAreaMapViewController.mapRegion = self.mapRegion;
    
    [self addChildViewController:hostelAreaMapViewController];
    
    [self.containerView addSubview:hostelAreaMapViewController.view];
    
    hostelAreaMapViewController.view.frame = self.containerView.frame;
    
    [hostelAreaMapViewController didMoveToParentViewController:self];
    
}


-(void)viewDidLoad{
  
    
}


@end
