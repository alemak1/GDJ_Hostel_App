//
//  MKDirectionsRequest+HelperMethods.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "TransportationMode.h"

@interface MKDirectionsRequest (HelperMethods)

+(MKDirectionsRequest*)getDirectionsRequestToHostelForTransportationMode:(TRANSPORTATION_MODE)transportationMode;


+(MKDirections*) getDirectionsToHostelForTransportationMode:(TRANSPORTATION_MODE)transportationMode;


+(void)handleDirectionsResponseForHostelDirectionsRequest:(void(^)(MKDirectionsResponse* routeResponse, NSError* routeError))handleDirectionsResponse forTransportationMode:(TRANSPORTATION_MODE)transportationMode;

+(MKDirectionsResponse*)getDirectionsResponseForHostelDirectionsRequestForTransportationMode:(TRANSPORTATION_MODE)transportationMode;




@end
