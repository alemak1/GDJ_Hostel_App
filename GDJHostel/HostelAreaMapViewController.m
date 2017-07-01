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
    
    self.selectedOptions = [[NSMutableArray<NSNumber*> alloc] init];
   
    /** The Map Region centers around the hostel **/
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.5416277, 126.9507303), span);
    
    self.mapView.region = region;
    
    self.annotationManager = [[AnnotationManager alloc] initWithFilename:@"PlacemarksNearHostel"];
    
    
    [self.mapView addAnnotations:[self.annotationManager getAllAnnotations]];
    
    
     [self addObserver:self forKeyPath:@"selectedOptions" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:HostelAreaMapControllerContext];
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];

    
   
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"Selected options changed: %@ ",[self.selectedOptions description]);
    
    if(context == HostelAreaMapControllerContext){
        
        NSLog(@"Removing annotations...");
        
        [self.mapView removeAnnotations:self.mapView.annotations];
        
        for (NSNumber* option in self.selectedOptions) {
            
            SeoulLocationType locationType = (SeoulLocationType)[option integerValue];
            
            NSLog(@"Adding annotations for locationType %d",locationType);
            
            [self.mapView addAnnotations:[self.annotationManager getAnnotationsOfType:locationType]];
        
        }
        
        
    
        
        
        NSNumber* changeKind = [change valueForKey:NSKeyValueChangeKindKey];
        
        if([changeKind integerValue] == NSKeyValueChangeInsertion){
            NSIndexSet* insertedOptions = [change valueForKey:NSKeyValueChangeIndexesKey];
            
            NSLog(@"New options added");

        }
        
        if([changeKind integerValue] == NSKeyValueChangeRemoval){
            
            NSIndexSet* removedOptions = [change valueForKey:NSKeyValueChangeIndexesKey];
            
            NSLog(@"Old options removed");
            
        }
    
        
    }
}


-(void)viewDidDisappear:(BOOL)animated{
    [self removeObserver:self forKeyPath:@"selectedOptions"];

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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"presentMapViewOptionsSegue"]){
        
        
    }
}

- (IBAction)showAnnotationOptionsController:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"presentMapViewOptionsSegue" sender:nil];
}
@end
