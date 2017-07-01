//
//  ToHostelDirectionsController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/19/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "ToHostelDirectionsController.h"

@interface ToHostelDirectionsController ()

typedef enum TRANSPORTATION_MODE{
    WALK = 0,
    TRANSIT,
    CAR
}TRANSPORTATION_MODE;



/** Primary MapView, which will show the route to the hostel from the user's starting location **/

@property (weak, nonatomic) IBOutlet MKMapView *routeDisplayMap;

/** Additional labels which indicate the distance and time to the hostel from the user's current location **/

@property (weak, nonatomic) IBOutlet UILabel *distanceToHostelIndicator;
@property (weak, nonatomic) IBOutlet UILabel *travelTimeIndicator;

/** A segmented control allows the user to make directions requests for different transportation types **/

@property (weak, nonatomic) IBOutlet UISegmentedControl *transportationMode;


/** Callback for responding to the user selection of a new transportation type **/

- (IBAction)makeRequestForNewTransportationType:(UISegmentedControl *)sender;



/** NumberFormatters for the distance and type to the hostel are preconfigured, lazily loaded **/

@property (readonly) NSNumberFormatter* travelTimeNumberFormatter;
@property (readonly) NSNumberFormatter* distanceNumberFormatter;
@property (readonly) NSString* selectedTransportationMode;

- (IBAction)dismissCurrentViewController:(UIButton *)sender;

- (IBAction)viewDirectionsToHostelWithMapsApp:(UIButton *)sender;

@end

@implementation ToHostelDirectionsController


-(void)viewWillLayoutSubviews{
    
    [[self routeDisplayMap] setDelegate:self];

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    MKMapItem* fromLocation = [MKMapItem mapItemForCurrentLocation];
    CLLocationCoordinate2D fromLocationCoordinate = fromLocation.placemark.coordinate;
    
    [self.routeDisplayMap setRegion:MKCoordinateRegionMake(fromLocationCoordinate, MKCoordinateSpanMake(0.50, 0.50))];
    
    
    
    TRANSPORTATION_MODE selected_transportation_mode = (int)[[self transportationMode] selectedSegmentIndex];
    
    [self makeDirectionsToHostelRequestFromUserLocationForTransportationType:selected_transportation_mode];
   
    
    
}


-(void)viewDidLoad{
    
    
    
    
   
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    
    if([keyPath isEqualToString:@"directionsResponse.routes"]){
        
        NSLog(@"The observed variable: directionsResponse.routes has changed");
        
        [self showDirections:[self directionsResponse]];
        
        MKRoute* firstRoute = self.directionsResponse.routes[0];
        
        double estimatedTravelTime = firstRoute.expectedTravelTime;
        double estimatedDistance = firstRoute.distance;
        
        [self setTravelDistanceWith:estimatedDistance];
        [self setTravelTimeWith:estimatedTravelTime];
        
        NSUInteger keyValueChangeKind = [change valueForKey:NSKeyValueChangeKindKey];
    
        if(keyValueChangeKind == NSKeyValueChangeInsertion){
            NSIndexSet* insertedIndices = [change valueForKey:NSKeyValueChangeIndexesKey];
        
            NSLog(@"The index set return is %@", [insertedIndices description]);
    
        }
    }
}

- (IBAction)makeRequestForNewTransportationType:(UISegmentedControl *)sender{
    
    NSLog(@"Making route request based on new transportation mode...");
    
    TRANSPORTATION_MODE selected_transportation_mode = (int)[[self transportationMode] selectedSegmentIndex];
    
    [self makeDirectionsToHostelRequestFromUserLocationForTransportationType:selected_transportation_mode];
    
}


- (void) showDirections:(MKDirectionsResponse*) response{
    
    [self.routeDisplayMap removeOverlays:self.routeDisplayMap.overlays];
    
    for(MKRoute* route in response.routes){
        [[self routeDisplayMap] addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
    }
}

/** TODO: Consider using generics **/

- (void) setTravelTimeWith:(double)travelTime{
    
    NSNumber* travelTimeNumber = [NSNumber numberWithDouble:travelTime];
    
    NSString* travelTimeString = [[self travelTimeNumberFormatter] stringFromNumber:travelTimeNumber];;
    
    
    [self.travelTimeIndicator setText:travelTimeString];
}

/** TODO: Consider using generics **/

- (void) setTravelDistanceWith:(double)distance{
    
    NSNumber* distanceNumber = [NSNumber numberWithDouble:distance];
    
    NSString* distanceString = [[self distanceNumberFormatter] stringFromNumber:distanceNumber];;
    
    [[self distanceToHostelIndicator] setText:distanceString];
    
}

-(void) makeDirectionsToHostelRequestFromUserLocationForTransportationType:(TRANSPORTATION_MODE)transportationMode{
    
    NSLog(@"Making direction request based on selected transportation mode: %@", [self selectedTransportationMode]);
    
    MKDirectionsRequest* routeRequest = [[MKDirectionsRequest alloc] init];
    
    switch (transportationMode) {
        case WALK:
            routeRequest.transportType = MKDirectionsTransportTypeWalking;
            break;
        case TRANSIT:
            routeRequest.transportType = MKDirectionsTransportTypeTransit;
            break;
        case CAR:
            routeRequest.transportType = MKDirectionsTransportTypeAutomobile;
            break;
        default:
            routeRequest.transportType = MKDirectionsTransportTypeAny;
            break;
    }
    
    /** Currenet location is obtained from class method, which returns the user location singleton instance **/
    
    MKMapItem* currentLocation = [MKMapItem mapItemForCurrentLocation];
    
    //TODO: Use a global constant for Ina's Hostel coordinate
    
    CLLocationCoordinate2D hostelLocationCoordinate = CLLocationCoordinate2DMake(37.541593, 126.952866);
    
    MKPlacemark* hostelPlacemark = [[MKPlacemark alloc] initWithCoordinate:hostelLocationCoordinate];
    
    MKMapItem* hostelLocation = [[MKMapItem alloc] initWithPlacemark:hostelPlacemark];
    
    [routeRequest setSource:currentLocation];
    
    [routeRequest setDestination:hostelLocation];
    
    MKDirections* routeDirections = [[MKDirections alloc] initWithRequest:routeRequest];
    
    [routeDirections calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse* routeResponse, NSError* routeError){
        
        if(routeError){
            //TODO: Implement error handling; show alert
        } else {
            
            /** Store the direction response in stored property registered for KVO**/
            
            NSLog(@"Request processed. Route Response Info: %@", [routeResponse description]);
            
            [self showDirections:routeResponse];
            
            MKRoute* firstRoute = routeResponse.routes[0];
            
            double estimatedTravelTime = firstRoute.expectedTravelTime;
            double estimatedDistance = firstRoute.distance;
            
            [self setTravelDistanceWith:estimatedDistance];
            [self setTravelTimeWith:estimatedTravelTime];

        }
        
    }];

}


-(NSNumberFormatter *)travelTimeNumberFormatter{
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    
    
    return numberFormatter;
}

-(NSNumberFormatter *)distanceNumberFormatter{
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    
    return numberFormatter;
}

-(NSString *)selectedTransportationMode{
    
    TRANSPORTATION_MODE selectedTransportationMode = (int)[[self transportationMode] selectedSegmentIndex];
    
    switch (selectedTransportationMode) {
        case WALK:
            return @"WALKING";
        case TRANSIT:
            return @"TRANSIT";
        case CAR:
            return @"CAR";
        default:
            return @"ANY TRANSIT";
    }
    
}

- (IBAction)dismissCurrentViewController:(UIButton *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)viewDirectionsToHostelWithMapsApp:(UIButton *)sender {
    
    MKMapItem* fromLocation = [MKMapItem mapItemForCurrentLocation];
    CLLocationCoordinate2D fromLocationCoordinate = fromLocation.placemark.coordinate;
    
    
    CLLocationCoordinate2D hostelLocationCoordinate = CLLocationCoordinate2DMake(37.541593, 126.952866);
    
    MKPlacemark* hostelPlacemark = [[MKPlacemark alloc] initWithCoordinate:hostelLocationCoordinate];
    
    MKMapItem* hostelLocation = [[MKMapItem alloc] initWithPlacemark:hostelPlacemark];
    
    
    MKMapItem* toLocation = hostelLocation;
    
    CLLocationDistance distanceBetweenEndpoints = [fromLocation.placemark.location distanceFromLocation:hostelLocation.placemark.location];
    
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



@end






/** For generating constraints programmatically:
 
 
 @property MKMapView* routingMap;
 
 @property UILabel* distanceToHostelLabel;
 @property UILabel* travelTimeToHostelLabel;
 
 @property UILabel* distanceToHostel;
 @property UILabel* travelTimeToHostel;
 
 
 //Constraints
 
 typedef NSArray<NSLayoutConstraint*>* LayoutConstraintsArray;
 typedef LayoutConstraintsArray(^ConstraintGenerator)(void);
 
 @property (readonly) LayoutConstraintsArray routingMapConstraints;
 @property (readonly) LayoutConstraintsArray distanceToHostelLabelConstraints;
 @property (readonly) LayoutConstraintsArray distanceToHostelConstraints;
 @property (readonly) LayoutConstraintsArray travelTimeToHostelLabelConstraints;
 @property (readonly) LayoutConstraintsArray travelTimeToHostelConstraints;

 
 //Execute in willLayoutSubview
 
 [self.view setBackgroundColor:[UIColor orangeColor]];
 
 _routingMap = [[MKMapView alloc] init];
 [self.view addSubview:[self routingMap]];
 [self.routingMap setDelegate:self];
 
 [NSLayoutConstraint activateConstraints:[self routingMapConstraints]];


 -(LayoutConstraintsArray)routingMapConstraints{
 
 LayoutConstraintsArray cwchConstraints = [NSArray arrayWithObjects:[
 [[self routingMap] leftAnchor] constraintEqualToAnchor:[self.view leftAnchor] constant:0.00],
 [[[self routingMap] topAnchor] constraintEqualToAnchor:[self.view topAnchor] constant:0.00],
 [[[self routingMap] bottomAnchor] constraintEqualToAnchor:[self.view bottomAnchor] constant:0.00],
 [[[self routingMap] widthAnchor] constraintEqualToAnchor:[self.view widthAnchor] multiplier:0.50],
 nil];
 
 LayoutConstraintsArray cwrhConstraints = [NSArray arrayWithObjects:[
 [[self routingMap] leftAnchor] constraintEqualToAnchor:[self.view leftAnchor] constant:0.00],
 [[[self routingMap] topAnchor] constraintEqualToAnchor:[self.view topAnchor] constant:0.00],
 [[[self routingMap] rightAnchor] constraintEqualToAnchor:[self.view rightAnchor] constant:0.00],
 [[[self routingMap] heightAnchor] constraintEqualToAnchor:[self.view widthAnchor] multiplier:0.50],
 nil];
 
 
 LayoutConstraintsArray rwchConstraints = [NSArray arrayWithObjects:nil, nil];
 
 LayoutConstraintsArray rwrhConstraints = [NSArray arrayWithObjects:nil, nil];
 
 
 
 ConstraintGenerator routingMapConstraintsGenerator = [self getConstraintGeneratorForCWCH: cwchConstraints
 
 andForCWRH:cwrhConstraints
 
 andForRWCH:rwchConstraints
 
 andForRWRH:rwrhConstraints];
 
 return routingMapConstraintsGenerator();
 }
 
 -(LayoutConstraintsArray)distanceToHostelConstraints{
 
 ConstraintGenerator distanceToHostelConstraintsGenerator = [self getConstraintGeneratorForCWCH:[NSArray arrayWithObjects:nil, nil] andForCWRH:[NSArray arrayWithObjects:nil, nil] andForRWCH:[NSArray arrayWithObjects:nil, nil] andForRWRH:[NSArray arrayWithObjects:nil, nil]];
 
 return distanceToHostelConstraintsGenerator();
 }
 
 
 -(LayoutConstraintsArray)distanceToHostelLabelConstraints{
 
 ConstraintGenerator distanceToHostelLabelConstraintsGenerator = [self getConstraintGeneratorForCWCH:[NSArray arrayWithObjects:nil, nil] andForCWRH:[NSArray arrayWithObjects:nil, nil] andForRWCH:[NSArray arrayWithObjects:nil, nil] andForRWRH:[NSArray arrayWithObjects:nil, nil]];
 
 return distanceToHostelLabelConstraintsGenerator();
 }
 
 -(LayoutConstraintsArray)travelTimeToHostelConstraints{
 
 ConstraintGenerator travelTimeToHostelConstraintsGenerator = [self getConstraintGeneratorForCWCH:[NSArray arrayWithObjects:nil, nil] andForCWRH:[NSArray arrayWithObjects:nil, nil] andForRWCH:[NSArray arrayWithObjects:nil, nil] andForRWRH:[NSArray arrayWithObjects:nil, nil]];
 
 return travelTimeToHostelConstraintsGenerator();
 }
 
 -(LayoutConstraintsArray)travelTimeToHostelLabelConstraints{
 
 ConstraintGenerator travelTimeToHostelLabelConstraintsGenerator = [self getConstraintGeneratorForCWCH:[NSArray arrayWithObjects:nil, nil] andForCWRH:[NSArray arrayWithObjects:nil, nil] andForRWCH:[NSArray arrayWithObjects:nil, nil] andForRWRH:[NSArray arrayWithObjects:nil, nil]];
 
 return travelTimeToHostelLabelConstraintsGenerator();
 }
 
 
 
 
 -(ConstraintGenerator) getConstraintGeneratorForCWCH:(LayoutConstraintsArray)cwchConstraintGenerator andForCWRH:(LayoutConstraintsArray)cwrhConstraintGenerator andForRWCH:(LayoutConstraintsArray)rwchConstraintGenerator andForRWRH:(LayoutConstraintsArray)rwrhConstraintGenerator{
 
 return ^{
 
 UITraitCollection* currentTraitCollection = [self traitCollection];
 UIUserInterfaceSizeClass currentHorizontalClass = [currentTraitCollection horizontalSizeClass];
 UIUserInterfaceSizeClass currentVerticalClass = [currentTraitCollection verticalSizeClass];
 
 BOOL CompactWidth_CompactHeight = (currentVerticalClass == UIUserInterfaceSizeClassCompact && currentHorizontalClass == UIUserInterfaceSizeClassCompact);
 
 BOOL CompactWidth_RegularHeight = (currentVerticalClass == UIUserInterfaceSizeClassRegular && currentHorizontalClass == UIUserInterfaceSizeClassCompact);
 
 BOOL RegularWidth_CompactHeight = (currentVerticalClass == UIUserInterfaceSizeClassCompact && currentHorizontalClass == UIUserInterfaceSizeClassRegular);
 
 BOOL RegularWidth_RegularHeight = (currentVerticalClass == UIUserInterfaceSizeClassRegular && currentHorizontalClass == UIUserInterfaceSizeClassRegular);
 
 
 if(CompactWidth_CompactHeight){
 return cwchConstraintGenerator;
 }
 
 if(CompactWidth_RegularHeight){
 return cwrhConstraintGenerator;
 }
 
 if(RegularWidth_CompactHeight){
 return rwchConstraintGenerator;
 }
 
 if(RegularWidth_RegularHeight){
 return rwrhConstraintGenerator;
 
 }
 
 return [[NSArray<NSLayoutConstraint*> alloc] init];
 };
 
 }
 **/


