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

@synthesize annotationsFileSource = _annotationsFileSource;
@synthesize polygonOverlayFileSources = _polygonOverlayFileSources;
@synthesize annotationViewImagePath = _annotationViewImagePath;
@synthesize mapCoordinateRegion = _mapCoordinateRegion;

-(void)viewWillLayoutSubviews{
    
    [self.mapView setDelegate:self];
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self loadWarMemorialAnnotationsArray];
    
    [self loadAnnotations];
    
    
    [self loadPolygonOverlays];
    
    /** [self loadCircleOverlays]; **/
    
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    
 
    [self setMapRegion];
}


-(void)viewDidLoad{
    
}

#pragma makr ****** MKMapViewDelegate Methods


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKAnnotationView* view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapAnnotation"];
    
    
    view.image = [UIImage imageNamed:self.annotationViewImagePath];
    
    return view;
}
 


-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    //Set the label and the image view with annotation objects description text and image path respectively
    
    
    WarMemorialAnnotation* annotation = [self getWarMemorialAnnotationForAnnotationView:view];
    
    
  
    
    NSString* labelString = annotation.title;
    

    NSDictionary* attributedStringDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Futura-Bold" size:30.0],NSFontAttributeName,[UIColor greenColor],NSForegroundColorAttributeName, nil];
    
    
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:labelString attributes:attributedStringDict];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        
        NSString* descriptionText = @" / ";
        descriptionText = [descriptionText stringByAppendingString:annotation.subtitle];
        
        NSDictionary* descriptionTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Futura-Medium" size:20.0],NSFontAttributeName,[UIColor greenColor],NSForegroundColorAttributeName, nil];
        
        NSAttributedString* attributedDescriptionString = [[NSAttributedString alloc] initWithString:descriptionText attributes:descriptionTextAttributes];
        
        [attributedString insertAttributedString:attributedDescriptionString atIndex:[labelString length]];
        
    }
    
    
    
    [self.annotationLabel setAdjustsFontSizeToFitWidth:YES];
    [self.annotationLabel setMinimumScaleFactor:0.50];
    [self.annotationLabel setNumberOfLines:0];
    
    [self.annotationLabel setAttributedText:attributedString];
    
    [self.annotationImageView setImage:[UIImage imageNamed:annotation.imagePath]];
    
}


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    if([overlay isKindOfClass:[MKCircle class]]){
        MKCircleRenderer* circleView = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        [circleView setStrokeColor:[UIColor redColor]];
        
        return circleView;
    } else if([overlay isKindOfClass:[MKPolyline class]]){
        
        MKPolylineRenderer* polygonView = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        
        
        [polygonView setStrokeColor:[UIColor greenColor]];
        
        return polygonView;
        
    }
    
    return nil;
}


-(void)loadWarMemorialAnnotationsArray{
    
    self.annotationStore = [[NSMutableArray alloc] init];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:self.annotationsFileSource ofType:@"plist"];
    
    NSArray* warMemorialDictArray = [NSArray arrayWithContentsOfFile:path];
    
    for(NSDictionary*dict in warMemorialDictArray){
        WarMemorialAnnotation* annotation = [[WarMemorialAnnotation alloc] initWithDict:dict];
        

        [self.annotationStore addObject:annotation];
        
    
    }
    
    
    [self.mapView addAnnotations:self.annotationStore];
    
}

-(void) setMapRegion{
    

    [self.mapView setRegion:self.mapCoordinateRegion];
    
}


-(void) loadAnnotations{
    
    [self.mapView addAnnotations:self.annotationStore];
}


-(void) loadCircleOverlays{
    
    for(WarMemorialAnnotation* annotation in self.annotationStore){
        
        CLLocationCoordinate2D circleCenter = [annotation coordinate];
        
        MKCircle* circleOverlay = [MKCircle circleWithCenterCoordinate:circleCenter radius:30.0];
        
        NSLog(@"Adding circle overlay with description %@",[circleOverlay description]);
        
        [self.mapView addOverlay:circleOverlay];
    }
}


-(void) loadPolygonOverlays{
    
  
    for(NSString* filePath in self.polygonOverlayFileSources){
        [self loadPolygonOverlayWithFileName:filePath];
    }
    
}


- (void) loadPolygonOverlayWithFileName:(NSString*)fileName{
    
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
    
    NSLog(@"Adding polyline with description: %@",[mainBuildingPolyline description]);
    
    [self.mapView addOverlay:mainBuildingPolyline];
}


-(WarMemorialAnnotation*)getWarMemorialAnnotationForAnnotationView:(MKAnnotationView*)view{
    
    for(WarMemorialAnnotation* warAnnotation in self.annotationStore){
        
        if(warAnnotation.title == view.annotation.title){
            
            return view.annotation;
            
        }
        
    }
    
    return nil;
}


/** Getters and setters for exposed properties **/

-(void)setAnnotationsFileSource:(NSString *)annotationsFileSource{
    _annotationsFileSource = annotationsFileSource;
}

-(NSString*)annotationsFileSource{
    return _annotationsFileSource;
}




@end
