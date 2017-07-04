//
//  WarMemorialNavigationController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "WarMemorialNavigationController.h"
#import "WarMemorialAnnotation.h"

@interface WarMemorialNavigationController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *annotationImageView;

@property (weak, nonatomic) IBOutlet UILabel *annotationLabel;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@property NSMutableArray<WarMemorialAnnotation*>* annotationStore;

@end

@implementation WarMemorialNavigationController


-(void)viewWillLayoutSubviews{
    
    [self.mapView setDelegate:self];
    [self.mapView removeOverlays:self.mapView.overlays];
    
    
    [self loadWarMemorialAnnotationsArray];
    
    
  
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self loadAnnotations];
    [self loadPolygonOverlays];
    [self loadCircleOverlays];
    
    [self setMapRegion];
}


-(void)viewDidLoad{
    
}

#pragma makr ****** MKMapViewDelegate Methods

/**
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    return nil;
}
 
 **/

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    //Set the label and the image view with annotation objects description text and image path respectively
    
    //view.annotation.title
    
    //use the title to filter the im
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    if([overlay isKindOfClass:[MKCircle class]]){
        MKCircleRenderer* circleView = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        [circleView setStrokeColor:[UIColor redColor]];
        
        return circleView;
    } else if([overlay isKindOfClass:[MKPolygon class]]){
        
        MKPolygonRenderer* polygonView = [[MKPolygonRenderer alloc] initWithOverlay:overlay];
        
        [polygonView setStrokeColor:[UIColor blueColor]];
        
        return polygonView;
        
    }
    
    return nil;
}


-(void)loadWarMemorialAnnotationsArray{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"KoreanWarMemorialCircleRegions" ofType:@"plist"];
    
    NSArray* warMemorialDictArray = [NSArray arrayWithContentsOfFile:path];
    
    for(NSDictionary*dict in warMemorialDictArray){
        WarMemorialAnnotation* annotation = [[WarMemorialAnnotation alloc] initWithDict:dict];
        
        
        [self.annotationStore addObject:annotation];
    }
    
    
}

-(void) setMapRegion{
    
    CLLocationCoordinate2D lowerRight = CLLocationCoordinate2DMake(37.5348, 126.9788);
    CLLocationCoordinate2D upperRight = CLLocationCoordinate2DMake(37.5380, 126.9788);
    CLLocationCoordinate2D upperLeft = CLLocationCoordinate2DMake(37.5380, 126.9755);
    
    CLLocationCoordinate2D mainEntrance = CLLocationCoordinate2DMake(37.5365, 126.9772);
    
    CLLocationDegrees latDifference = fabs(upperRight.latitude - lowerRight.latitude);
    CLLocationDegrees longDifference = fabs(upperRight.longitude - upperLeft.longitude);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(latDifference, longDifference);
    MKCoordinateRegion region = MKCoordinateRegionMake(mainEntrance, span);
    
    [self.mapView setRegion:region];
    
}


-(void) loadAnnotations{
    
    [self.mapView addAnnotations:self.annotationStore];
}


-(void) loadCircleOverlays{
    
    for(WarMemorialAnnotation* annotation in self.annotationStore){
        
        CLLocationCoordinate2D circleCenter = [annotation coordinate];
        
        MKCircle* circleOverlay = [MKCircle circleWithCenterCoordinate:circleCenter radius:10.0];
        
        [self.mapView addOverlay:circleOverlay];
    }
}


-(void) loadPolygonOverlays{
    
    [self loadPolygonOveralyWithFileName:@"WarMemorialMainBuilding"];
    [self loadPolygonOveralyWithFileName:@"WeddingHall"];
    
}


- (void) loadPolygonOveralyWithFileName:(NSString*)fileName{
    NSString* mainBuildingPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    
    NSDictionary* mainBuildingDict = [NSDictionary dictionaryWithContentsOfFile:mainBuildingPath];
    
    NSArray* pointsArray = mainBuildingDict[@"boundary"];
    
    NSInteger pointsCount = pointsArray.count;
    
    CLLocationCoordinate2D pointsToUse[pointsCount];
    
    for(int i = 0; i < pointsCount; i++){
        CGPoint p =  CGPointFromString(pointsArray[i]);
        pointsToUse[i] = CLLocationCoordinate2DMake(p.x, p.y);
    }
    
    MKPolyline* mainBuildingPolyline = [MKPolyline polylineWithCoordinates:pointsToUse count:pointsCount];
    
    [self.mapView addOverlay:mainBuildingPolyline];
}


-(WarMemorialAnnotation*)getWarMemorialAnnotationForAnnotationView:(MKAnnotationView*)view{
    
    return nil;
}


@end
