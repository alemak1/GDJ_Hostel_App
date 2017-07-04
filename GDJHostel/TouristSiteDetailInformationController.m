//
//  TouristSiteDetailInformationController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/28/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristSiteDetailInformationController.h"
#import "UIViewController+HelperMethods.h"
#import "NSString+HelperMethods.h"
#import "AppLocationManager.h"

@interface TouristSiteDetailInformationController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isOpenSwitch;

@property (weak, nonatomic) IBOutlet UIImageView *siteImageView;
@property (weak, nonatomic) IBOutlet UILabel *operatingHoursLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *admissionFeeLabel;

@property (weak, nonatomic) IBOutlet UILabel *daysClosedLabel;

@property (weak, nonatomic) IBOutlet UILabel *specialNoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeUntilCloseLabel;

- (IBAction)getDirectionsButton:(UIButton *)sender;
- (IBAction)loadWebsiteButton:(UIButton *)sender;


- (IBAction)launchRegionMonitoringForSite:(UISwitch *)sender;

- (IBAction)changedRegionMonitoringStatus:(UISwitch *)sender;

@property CLRegion* monitoredRegion;

@end

@implementation TouristSiteDetailInformationController

typedef void(^LoadDirectionsFunction)(void);
LoadDirectionsFunction _directionsRequest = nil;

typedef void(^LoadWebsiteFunction)(void);
LoadWebsiteFunction _loadWebsiteRequest = nil;

static void* TouristSiteDetailInformationContext = &TouristSiteDetailInformationContext;

-(void)viewWillAppear:(BOOL)animated{
    
    _loadWebsiteRequest = ^{
        [self loadWebsiteWithURLAddress:self.touristSiteConfiguration.webAddress];
    };
    
}

-(void)viewDidLoad{
    [self addObserver:self forKeyPath:@"touristSiteConfiguration" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:TouristSiteDetailInformationContext];
    
    
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if(context == TouristSiteDetailInformationContext){
        NSLog(@"Responding to observed change in touristConfiguraiton object");
        
        /** Configure isUnderRegionMonitoringSwitch **/
        
        [self configureRegionMonitoringSwitch];
        
        
        /** Configure Site Description Label **/
        
        [self configureSiteDescriptionLabel];
        
        
        
        /** Configure the image for the site detail view **/
        
        UIImage* siteImage = [UIImage imageNamed:[self.touristSiteConfiguration imagePath]];
        [self.siteImageView setImage:siteImage];
        
        
        /** Configure text for the title and description labels **/
        [self.titleLabel setText:[self.touristSiteConfiguration title]];
        [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self.titleLabel setMinimumScaleFactor:0.25];
        
        
        /** Configure address label **/
        
        [self.addressLabel setText:[self.touristSiteConfiguration physicalAddress]];
        [self.addressLabel setAdjustsFontSizeToFitWidth:YES];
        [self.addressLabel setMinimumScaleFactor:0.25];

        
        /** Configure operating hours label **/
        
        [self configureOperatingHoursLabel];
      
        
        /** Store the map request function **/
        
        TouristSiteDetailInformationController* __weak weakSelf = self;
        
        _directionsRequest = ^{
            
            CLLocationCoordinate2D toLocation = weakSelf.touristSiteConfiguration.midCoordinate;
            
            MKPlacemark* toLocationPlacemark = [[MKPlacemark alloc] initWithCoordinate:toLocation];
            
            MKMapItem* toLocationItem = [[MKMapItem alloc] initWithPlacemark:toLocationPlacemark];
            
            // Create a region centered on the starting point with a 10km span
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(toLocation, 10000, 10000);
            
            // Open the item in Maps, specifying the map region to display.
            [MKMapItem openMapsWithItems:[NSArray arrayWithObject:toLocationItem]
                           launchOptions:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSValue valueWithMKCoordinate:region.center], MKLaunchOptionsMapCenterKey,
                                          [NSValue valueWithMKCoordinateSpan:region.span], MKLaunchOptionsMapSpanKey, nil]];
        
        };
        
        /** Store the web loading request function **/
        
        _loadWebsiteRequest = ^{
        
            NSString* webAddress = weakSelf.touristSiteConfiguration.webAddress;
            
            [self loadWebsiteWithURLAddress:webAddress];
            
            NSLog(@"Loading website at %@",webAddress);
        
        };
    }
}


-(void)configureSiteDescriptionLabel{
    
    NSString* baseDescriptionString = (self.touristSiteConfiguration.siteDescription != nil) ? self.touristSiteConfiguration.siteDescription : @"";
    
    /** Configure text for the admission fee **/
    
    baseDescriptionString = [self appendAdmissionFeeString:baseDescriptionString];
    
   
    /** Configure text for the number of days closed  **/

    baseDescriptionString = [self appendNumberOfDaysClosedString:baseDescriptionString];
    
    
    /** Configure the Time Until Closing/Opening Label **/
    
    //baseDescriptionString = [self appendOpeningClosingTimeStrings:baseDescriptionString];
    
    
    /** Configure the Special Note Label **/
    
    baseDescriptionString = [self appendSpecialNoteString:baseDescriptionString];
    
    /** Set text for the description label **/
    
    [self.descriptionLabel setText:baseDescriptionString];
    
}


-(NSString*) appendSpecialNoteString:(NSString*)baseDescriptionString{
    NSString* noteText = [self.touristSiteConfiguration specialNote];
    
    noteText = noteText != nil ? noteText : @"";
    
    baseDescriptionString = [baseDescriptionString stringByAppendingString:@" / "];
    
    baseDescriptionString = [baseDescriptionString stringByAppendingString:noteText];
    
    return baseDescriptionString;
}

- (NSString*) appendOpeningClosingTimeStrings: (NSString*) baseDescriptionString {
    CGFloat openingTime = [[self.touristSiteConfiguration openingTime] doubleValue];
    CGFloat closingTime = [[self.touristSiteConfiguration closingTime] doubleValue];
    
    
    NSString* timeUntilText = @"";
    
    if(openingTime < 0.00 || closingTime < 0.00){
        timeUntilText = @"";
    } else {
        timeUntilText = [self.touristSiteConfiguration isOpen] ? @"Time Until Closing: " : @"Time Until Opening: ";
        
        NSString* appendedString = [self.touristSiteConfiguration isOpen] ? [self.touristSiteConfiguration timeUntilClosingString] : [self.touristSiteConfiguration timeUntilOpeningString];
        
        timeUntilText = [timeUntilText stringByAppendingString:appendedString];
    }
    
    baseDescriptionString = [baseDescriptionString stringByAppendingString:@" / "];
    
    baseDescriptionString = [baseDescriptionString stringByAppendingString:timeUntilText];
    
    
    return baseDescriptionString;
}

- (NSString*) appendAdmissionFeeString:(NSString*)baseDescriptionString{
    /** Configure text for the admission fee **/
    
    CGFloat admissionFee = [self.touristSiteConfiguration admissionFee];
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMinimumFractionDigits:2];
    
    NSString* admissionFeeString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:admissionFee]];
    
    NSString* admissionFeeLabelText = admissionFee > 0 ? [NSString stringWithFormat:@"Admission Fee: %@",admissionFeeString] : @"Admission: Free";
    
    baseDescriptionString = [baseDescriptionString stringByAppendingString:@" / "];
    
    baseDescriptionString = [baseDescriptionString stringByAppendingString:admissionFeeLabelText];
    
    return baseDescriptionString;
}

- (NSString*) appendNumberOfDaysClosedString:(NSString*)baseDescriptionString{
    /** Configure days closed label **/
    
    int numberOfDaysClosed = [self.touristSiteConfiguration numberOfDaysClosed];
    int* daysClosed = [self.touristSiteConfiguration daysClosed];
    
    NSString* daysClosedString;
    
    daysClosedString = [[NSString alloc] init];
    
    if(numberOfDaysClosed <= 0){
        daysClosedString = @"Open Everyday";
    } else {
        daysClosedString = @"Closed on: ";
    }
    
    for(int i = 0; i < numberOfDaysClosed; i++){
        
        daysClosedString = [daysClosedString stringByAppendingString:[NSString getDayAbbreviation:daysClosed[i]]];
    }
    
    baseDescriptionString = [baseDescriptionString stringByAppendingString:@" / "];
    
    baseDescriptionString = [baseDescriptionString stringByAppendingString:daysClosedString];
    
    return baseDescriptionString;
}


- (void) configureOperatingHoursLabel{
    
    /** Configure operating hours label **/
    
    
    CGFloat openingTime = [[self.touristSiteConfiguration openingTime] doubleValue];
    CGFloat closingTime = [[self.touristSiteConfiguration closingTime] doubleValue];
    
    NSString* operatingHoursString = @"";
    
    if(openingTime < 0.00 || closingTime < 0.00){
        operatingHoursString = @"Open All Hours";
    } else {
        int openingTimeInSeconds = openingTime*3600;
        int closingTimeInSeconds = closingTime*3600;
        
        NSString* openingTimeString = [NSString timeFormattedStringFromTotalSeconds:openingTimeInSeconds];
        NSString* closingTimeString = [NSString timeFormattedStringFromTotalSeconds:closingTimeInSeconds];
        
        operatingHoursString = [NSString stringWithFormat:@"Operating Hours: %@ to %@",openingTimeString,closingTimeString];
    }
    
    
    [self.operatingHoursLabel setText:operatingHoursString];
    
    
}


-(void) configureRegionMonitoringSwitch{
    
    [self.isOpenSwitch setUserInteractionEnabled:YES];

    NSString* regionIdentifierString = [self.touristSiteConfiguration title];
    
    BOOL isBeingMonitored = [[UserLocationManager sharedLocationManager] isBeingRegionMonitored:regionIdentifierString];
    
   
    if(isBeingMonitored){
        self.monitoredRegion = [[UserLocationManager sharedLocationManager] getRegionWithIdentifier:self.touristSiteConfiguration.title];
        
        [self.isOpenSwitch setOn:YES];

    } else {
        
        [self.isOpenSwitch setOn:NO];

    }
    
    
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"touristSiteConfiguration"];
}

- (IBAction)getDirectionsButton:(UIButton *)sender {
    
    _directionsRequest();
}

- (IBAction)loadWebsiteButton:(UIButton *)sender {
    
    _loadWebsiteRequest();
}

- (IBAction)launchRegionMonitoringForSite:(UISwitch *)sender {
    
    UserLocationManager* locationManager = [UserLocationManager sharedLocationManager];
    
    if(self.monitoredRegion != nil){
        NSLog(@"Theh region is already being monitored");
        return;
    }
    
    if([sender isOn]){
        //Enable region monitoring
        
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Do you want to monitor this region for entry and exit?" message:@"If yes, the app will notify you when you enter and exit the proximity of this tourist site. " preferredStyle:UIAlertControllerStyleAlert];
        
        

        
        UIAlertAction* addRegionAction = [UIAlertAction actionWithTitle:@"Monitor Region" style:UIAlertActionStyleDefault handler:^(UIAlertAction* alertAction){
            

            
            NSLog(@"Configuring new region for region monitoring with region identifier: %@",[self.touristSiteConfiguration name]);
                
            
            CLRegion* newRegion = [self.touristSiteConfiguration getRegionFromTouristConfiguration];
                
            [locationManager startMonitoringForRegion:newRegion];
            [self.isOpenSwitch setOn:YES];
                
        
            
        }];

        
       
        
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action){
        
            [self.isOpenSwitch setOn:NO];
        }];
        
        [alertController addAction:addRegionAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
    } else {
        
        [locationManager stopMonitoringForRegion:[self.touristSiteConfiguration getRegionFromTouristConfiguration]];
        [self.isOpenSwitch setOn:NO];
       
        
    }
}

@end


/** Previous version allowed for user to specify the radius for entry/exit notifications
 
 /**
 [alertController addTextFieldWithConfigurationHandler:^(UITextField* textField){
 textField.placeholder = @"Enter monitoring radius...";
 
 }];
 **/

 /**
 
 UIAlertAction* addRegionAction = [UIAlertAction actionWithTitle:@"Monitor Region" style:UIAlertActionStyleDefault handler:^(UIAlertAction* alertAction){
 
 UITextField* radiusTextfield = [alertController.textFields objectAtIndex:0];
 NSString* radiusText = [radiusTextfield text];
 
 
 BOOL inputIsValid = YES;
 
 for(int i = 0; i < [radiusText length]; i++){
 if(!isnumber([radiusText characterAtIndex:i]) || ([radiusText length] <= 0)){
 UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Invalid Entry" message:@"Please enter a valid integer number for the radius of the monitoring region" preferredStyle:UIAlertControllerStyleAlert];
 
 UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
 
 [alertController addAction:okAction];
 
 [self presentViewController:alertController animated:YES completion:nil];
 [self.isOpenSwitch setOn:NO];
 
 inputIsValid = NO;
 }
 }
 
 if(inputIsValid){
 NSLog(@"Configuring new region for region monitoring with region identifier: %@",[self.touristSiteConfiguration name]);
 
 int monitoringRadius = [radiusText doubleValue];
 
 CLRegion* newRegion = [self.touristSiteConfiguration getRegionFromTouristConfiguration];
 
 [locationManager startMonitoringForRegion:newRegion];
 [self.isOpenSwitch setOn:YES];
 
 NSLog(@"Region monitoring has been turned on for circular region with coordinate(long/lat) %f,%f, monitoring radius %d, andw with identifier %@",self.touristSiteConfiguration.midCoordinate.longitude,self.touristSiteConfiguration.midCoordinate.latitude,monitoringRadius,self.touristSiteConfiguration.title);
 
 }
 
 }];
 **/


