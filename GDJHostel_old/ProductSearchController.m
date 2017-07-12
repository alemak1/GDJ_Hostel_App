//
//  ProductSearchController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/5/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "ProductSearchController.h"
#import "AppLocationManager.h"
#import "NSString+CurrencyHelperMethods.h"

@interface ProductSearchController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mainMapView;

@end

@implementation ProductSearchController


-(void)viewWillLayoutSubviews{
    
    [self.mainMapView setDelegate:self];
    
}

-(void)viewDidLoad{
    
    [self setMapRegionBasedOnCurrentUserLocation];
    
    if(self.searchNearHostel){
        [self performNearHostelSearch];
    } else {
        
        [self performGenericSearch];
    }

}


-(void)setMapRegionBasedOnCurrentUserLocation{
    
    CLLocation* currentLocation = [[UserLocationManager sharedLocationManager] getLastUpdatedUserLocation];
    
    CLLocationCoordinate2D centerCoordinate = currentLocation.coordinate;

    
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, MKCoordinateSpanMake(0.0001, 0.0001));
    
    
    [self.mainMapView setRegion:region];
    
}


-(void)performGenericSearch{
    
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    

    request.naturalLanguageQuery = [NSString getSearchQueryAssociatedWithAssortedProductCategory:self.assortedProductCategory];
    
    CLLocation* currentLocation = [[UserLocationManager sharedLocationManager] getLastUpdatedUserLocation];
    
    CLLocationCoordinate2D centerCoordinate = currentLocation.coordinate;
    
    
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, MKCoordinateSpanMake(0.0001, 0.0001));
    
    request.region = region;
    
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
     }];

    }



-(void)performNearHostelSearch{
    //TODO: add annotations for specific locations based on specific product categories
    
    [self.mainMapView removeAnnotations:[self.mainMapView annotations]];

    switch (self.assortedProductCategory) {
        case COFFEE:
            break;
        default:
            break;
    }
    
    //Add annotations, whic are filtered from an array initialized from a plist
    //[self.mainMapView showAnnotations:placemarks animated:NO];

}


-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    [[UserLocationManager sharedLocationManager] viewLocationInMapsTo:view.annotation.coordinate];
    
}

@end
/**
 
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
 
 
 
 **/

