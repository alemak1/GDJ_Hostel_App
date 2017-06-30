//
//  TouristSiteDetailInformationController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/28/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristSiteDetailInformationController.h"
#import "NSString+HelperMethods.h"

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


@end

@implementation TouristSiteDetailInformationController

typedef void(^LoadDirectionsFunction)(void);
LoadDirectionsFunction _directionsRequest = nil;

typedef void(^LoadWebsiteFunction)(void);
LoadWebsiteFunction _loadWebsiteRequest = nil;

static void* TouristSiteDetailInformationContext = &TouristSiteDetailInformationContext;

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidLoad{
    [self addObserver:self forKeyPath:@"touristSiteConfiguration" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:TouristSiteDetailInformationContext];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if(context == TouristSiteDetailInformationContext){
        NSLog(@"Responding to observed change in touristConfiguraiton object");
        
        /** Configure the image for the site detail view **/
        
        UIImage* siteImage = [UIImage imageNamed:[self.touristSiteConfiguration imagePath]];
        [self.siteImageView setImage:siteImage];
        
        
        
        
        /** Configure text for the title and description labels **/
        [self.titleLabel setText:[self.touristSiteConfiguration title]];
        [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self.titleLabel setMinimumScaleFactor:0.25];
        
        [self.descriptionLabel setText:[self.touristSiteConfiguration siteDescription]];
        
        

        /** Configure text for the admission fee **/
        
        CGFloat admissionFee = [self.touristSiteConfiguration admissionFee];
        
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMinimumFractionDigits:2];
        
        NSString* admissionFeeString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:admissionFee]];
        
        NSString* admissionFeeLabelText = admissionFee > 0 ? [NSString stringWithFormat:@"Admission Fee: %@",admissionFeeString] : @"Admission: Free";
        
        [self.admissionFeeLabel setText:admissionFeeLabelText];
        
        
        /** Configure the 'isOpen' switch **/
        
        [self.isOpenSwitch setOn:[self.touristSiteConfiguration isOpen]];
        [self.isOpenSwitch setUserInteractionEnabled:NO];
        
        
        
        /** Configure operating hours label **/
        
        CGFloat openingTime = [[self.touristSiteConfiguration openingTime] doubleValue];
        CGFloat closingTime = [[self.touristSiteConfiguration closingTime] doubleValue];
        
        NSString* operatingHoursString;
        
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
        
        
        /** Configure days closed label **/
        
        int numberOfDaysClosed = [self.touristSiteConfiguration numberOfDaysClosed];
        int* daysClosed = [self.touristSiteConfiguration daysClosed];
        
        NSString* daysClosedString;
        
        daysClosedString = [[NSString alloc] init];
        
        if(numberOfDaysClosed <= 0){
            daysClosedString = @"Open Everyday";
        }
        
        for(int i = 0; i < numberOfDaysClosed; i++){
            
            daysClosedString = [daysClosedString stringByAppendingString:[NSString getDayAbbreviation:i]];
        }
        
        [self.daysClosedLabel setText:daysClosedString];
        
        
        /** Configure the Time Until Closing/Opening Label **/
        
        NSString* timeUntilText;
        
        if(openingTime < 0.00 || closingTime < 0.00){
            timeUntilText = @"";
        } else {
            timeUntilText = [self.touristSiteConfiguration isOpen] ? @"Time Until Closing: " : @"Time Until Opening: ";
            
            NSString* appendedString = [self.touristSiteConfiguration isOpen] ? [self.touristSiteConfiguration timeUntilClosingString] : [self.touristSiteConfiguration timeUntilOpeningString];
            
            timeUntilText = [timeUntilText stringByAppendingString:appendedString];
        }
        
        
        [self.timeUntilCloseLabel setText:timeUntilText];
        
        /** Configure the Special Note Label **/
        
        NSString* noteText = [self.touristSiteConfiguration specialNote];
        
        if(noteText){
            [self.specialNoteLabel setText:[NSString stringWithFormat:@"Note: %@", noteText]];
        } else {
            [self.specialNoteLabel setText:@""];
        }
        
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
            
            NSLog(@"Loading website at %@",webAddress);
        
        };
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
@end
