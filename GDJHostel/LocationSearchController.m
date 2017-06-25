//
//  LocationSearchController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationSearchController.h"

@interface LocationSearchController ()

@property (weak, nonatomic) IBOutlet UISearchBar *locationSearchBar;

@property (weak, nonatomic) IBOutlet MKMapView *mainMapView;

@property MKMapItem* selectedLocation;


@end

@implementation LocationSearchController


-(void)viewWillLayoutSubviews{
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.mainMapView setDelegate:self];
    
    
    [self.locationSearchBar setDelegate:self];
}

-(void)viewDidLoad{
    
    //Configure the map view so that it's coordinate region is centered on GDJ hostel
    
    CLLocationCoordinate2D hostelLocationCoordinate = CLLocationCoordinate2DMake(37.541593, 126.952866);
    
    [self.mainMapView setRegion:MKCoordinateRegionMake(hostelLocationCoordinate, MKCoordinateSpanMake(0.01, 0.01))];
    
    
}


- (IBAction)dismissViewController:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)getDirectionsInMaps:(UIButton *)sender {
    
    
    if(!self.selectedLocation){
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"No Location Selected" message:@"Select a location on the map to get directions in the Apple Maps App" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:okayAction];
        
        [self showViewController:alertController sender:nil];
        
        return;
    }
    
    
    MKMapItem* fromLocation = [MKMapItem mapItemForCurrentLocation];
    CLLocationCoordinate2D fromLocationCoordinate = fromLocation.placemark.coordinate;
    
    MKMapItem* toLocation = self.selectedLocation;
    
    CLLocationDistance distanceBetweenEndpoints = [fromLocation.placemark.location distanceFromLocation:self.selectedLocation.placemark.location];
    
    // Create a region centered on the starting point with a 10km span
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(fromLocationCoordinate, distanceBetweenEndpoints*1.5, distanceBetweenEndpoints*1.5);
    
    
    NSLog(@"Current location: %@",[fromLocation description]);
    NSLog(@"Destination location: %@",[toLocation description]);
    
    // Open the item in Maps, specifying the map region to display.
    [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:toLocation,fromLocation, nil]
                   launchOptions:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSValue valueWithMKCoordinate:region.center], MKLaunchOptionsMapCenterKey,
                                  [NSValue valueWithMKCoordinateSpan:region.span], MKLaunchOptionsMapSpanKey,
                                  MKLaunchOptionsDirectionsModeDefault,MKLaunchOptionsDirectionsModeKey, nil]];
    
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    // Create and initialize a search request object.
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = [self.locationSearchBar text];
    
    request.region = [self.mainMapView region];
    
    // Create and initialize a search object.
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    // Start the search and display the results as annotations on the map.
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
    {
        NSMutableArray *placemarks = [NSMutableArray array];
        for (MKMapItem *item in response.mapItems) {
            [placemarks addObject:item.placemark];
        }
        
        [self.mainMapView removeAnnotations:[self.mainMapView annotations]];
        [self.mainMapView showAnnotations:placemarks animated:NO];
    }
     
     ];
    
    [self.locationSearchBar resignFirstResponder];
}



-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"Selected annotation view: %@", [view description]);
    
    CLLocationDegrees latitude = view.annotation.coordinate.latitude;
    CLLocationDegrees longitude = view.annotation.coordinate.longitude;

    
    self.selectedLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude)]];
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    self.selectedLocation = nil;
}

@end
