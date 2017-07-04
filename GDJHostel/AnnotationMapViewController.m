//
//  AnnotationMapViewController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "AnnotationMapViewController.h"


@interface AnnotationMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *getDirectionsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *getDirectionsImage;


@end





@implementation AnnotationMapViewController


-(void)viewWillAppear:(BOOL)animated{
    
    
}


-(void)viewDidLoad{
    
    [self.titleLabel setText:[self.annotation title]];
    [self.addressLabel setText:[self.annotation address]];
    
    
    
}

@end
