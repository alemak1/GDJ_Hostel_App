//
//  HostelAreaMapViewController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/23/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostelAreaMapViewController.h"


@interface HostelAreaMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypeControl;

- (IBAction)changeMapType:(UISegmentedControl *)sender;

- (IBAction)dismissNavigationController:(UIBarButtonItem *)sender;

@end


@implementation HostelAreaMapViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.mapView setDelegate:self];
    
    
    self.selectedOptions = [NSMutableArray array];
    self.overlayConfiguration = [[OverlayConfiguration alloc] initWithFilename:@"HostelArea"];
    
    NSLog(@"Overlay configuration debug info: %@",[self.overlayConfiguration description]);
    
    CLLocationDegrees latDelta = self.overlayConfiguration.overlayTopLeftCoordinate.latitude - self.overlayConfiguration.overlayBottomRightCoordinate.latitude;
    
    // think of a span as a tv size, measure from one corner to another
    MKCoordinateSpan span = MKCoordinateSpanMake(fabsf(latDelta), 0.0);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(self.overlayConfiguration.midCoordinate, span);
    
    self.mapView.region = region;
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];

    
    
}


- (IBAction)changeMapType:(UISegmentedControl *)sender {
    switch (self.mapTypeControl.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}

- (IBAction)dismissNavigationController:(UIBarButtonItem *)sender {
}
@end
