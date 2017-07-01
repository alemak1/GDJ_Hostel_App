//
//  BikeRouteMapController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BikeRouteMapController.h"


@interface BikeRouteMapController () <MKMapViewDelegate>

@end

@implementation BikeRouteMapController


-(void)viewWillLayoutSubviews{
    
    [self.bikeRouteMapView setDelegate:self];

    
    MKMapPoint firstPoint = self.bikeRoute.points[0];
    MKMapPoint lastPoint = self.bikeRoute.points[self.bikeRoute.pointCount-1];
    
    CLLocationCoordinate2D firstCoordinate = MKCoordinateForMapPoint(firstPoint);
    CLLocationCoordinate2D lastCoordinate = MKCoordinateForMapPoint(lastPoint);
    
    CLLocationDegrees latDegrees = fabs(lastCoordinate.latitude - firstCoordinate.latitude);
    CLLocationDegrees longDegrees = fabs(lastCoordinate.longitude - firstCoordinate.longitude);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(latDegrees, longDegrees);
    
    [self.bikeRouteMapView setRegion:MKCoordinateRegionMake(MKCoordinateForMapPoint(firstPoint), span)];
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [self.bikeRouteMapView removeOverlays:self.bikeRouteMapView.overlays];
    
    NSLog(@"About to add bike route polyline: %@",[self.bikeRoute description]);
    [self.bikeRouteMapView addOverlay:self.bikeRoute];
    
   
    
}

-(void)viewDidLoad{
    
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    if([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineRenderer* lineView = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        
        lineView.strokeColor = [UIColor greenColor];
        
        return lineView;
    }
    
    return nil;
}

@end
