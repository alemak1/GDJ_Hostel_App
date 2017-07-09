//
//  HostelAreaMapViewController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/23/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostelAreaMapViewController.h"
#import "HostelAreaMapOptionsController.h"
#import "AnnotationManager.h"
#import "HostelLocationAnnotationView.h"
#import "DirectionsMenuController.h"

@interface HostelAreaMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypeControl;

- (IBAction)changeMapType:(UISegmentedControl *)sender;

- (IBAction)dismissNavigationController:(UIBarButtonItem *)sender;

@property AnnotationManager* annotationManager;

- (IBAction)showAnnotationOptionsController:(UIBarButtonItem *)sender;



@end


@implementation HostelAreaMapViewController


static void* HostelAreaMapControllerContext = &HostelAreaMapControllerContext;

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.mapView setDelegate:self];
    
   
    /** The Map Region centers around the hostel **/

    
    self.mapView.region = self.mapRegion;
    
    self.annotationManager = [[AnnotationManager alloc] initWithFilename:self.annotationSourceFilePath];
    
    
    [self.mapView addAnnotations:[self.annotationManager getAllAnnotations]];
    
    
    
}




-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    /**
    if([keyPath isEqualToString:@"selectedOptions"]){
        
        [self.mapView removeAnnotations:self.mapView.annotations];
        
        for (NSNumber* option in self.selectedOptions) {
            
            SeoulLocationType locationType = (SeoulLocationType)[option integerValue];
            
            NSLog(@"Adding annotations for locationType %d",locationType);
            
            [self.mapView addAnnotations:[self.annotationManager getAnnotationsOfType:locationType]];
            
        }
        
    }
     **/
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    /**
    if(self.selectedOptions.count > 0){
   
        [self.mapView removeAnnotations:self.mapView.annotations];
    
        for (NSNumber* option in self.selectedOptions) {
        
            SeoulLocationType locationType = (SeoulLocationType)[option integerValue];
            
            [self.mapView addAnnotations:[self.annotationManager getAnnotationsOfType:locationType]];
        
        }
    }
     
     **/
   
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    SeoulLocationAnnotationView* annotationView = [[SeoulLocationAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"seoulLocationAnnotation"];
    
    return annotationView;
}


- (IBAction)showAnnotationOptionsController:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"presentMapViewOptionsSegue" sender:nil];
}


@end
