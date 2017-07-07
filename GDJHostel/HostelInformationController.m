//
//  HostelInformationController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/24/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostelInformationController.h"
#import "MenuComponent.h"
#import "AppLocationManager.h"

#import "OperatingDateTime.h"

@interface HostelInformationController ()

@property (nonatomic, strong) MenuComponent *menuComponent;
@property UIImageView* backgroundImageView;

- (void)showMenu:(UIGestureRecognizer *)gestureRecognizer;


@end

@implementation HostelInformationController

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    /** Initialize the user location manager and set its presenting view controller **/
    
    UserLocationManager* userLocationManager = [UserLocationManager sharedLocationManager];
    
    [userLocationManager setPresentingViewControllerTo:self];
    
    NSDate* chuseok2018 = [OperatingDateTime chuseokDateForGregorianYear:2018];
    NSDate* seoullal2018 = [OperatingDateTime seoullalDateForGregorianYear:2018];
    
    NSLog(@"2018 date for chuseok: %@",[chuseok2018 description]);
    NSLog(@"2018 date for seoullal: %@",[seoullal2018 description]);

    /** This hypothetical tourist site is open from Feb. 15 to Mar. 25 **/
    NSDictionary* operatingHoursDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"{46800,61200}",@"sundayOperatingRange",@"{46800,61200}",@"mondayOperatingRange",@"{46800,61200}",@"tuesdayOperatingRange",@"{46800,61200}",@"wednesdayOperatingRange",@"{46800,61200}",@"thursdayOperatingRange",@"{46800,61200}",@"fridayOperatingRange",@"{46800,61200}",@"saturdayOperatingRange", nil];
    
    OperatingDateTime* touristSiteODT = [[OperatingDateTime alloc] initWithStartingMonth:2 andWithStartingDay:15 andWithEndingMonth:3 andWithEndingDay:25 andWithOperatingHoursDictionary:operatingHoursDictionary];
    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents* components1 = [[NSDateComponents alloc] init];
    [components1 setMonth:1];
    [components1 setDay:20];
    
    NSDate* testDate1 = [gregorian dateFromComponents:components1];
    
    NSDateComponents* components2 = [[NSDateComponents alloc] init];
    [components2 setMonth:2];
    [components2 setDay:25];
    [components2 setHour:14];
    [components2 setMinute:23];
    
    NSDate* testDate2 = [gregorian dateFromComponents:components2];
    
    if(![touristSiteODT isWithinOperatingDayRange:testDate1]){
        NSLog(@"Test Date 1 is invalid!");
    };
    
    
    if([touristSiteODT isWithinOperatingDayRange:testDate2]){
        NSLog(@"Test Date 2 is valid!");
        
        if(![touristSiteODT isWithinOperatingHourRange:testDate2]){
            NSLog(@"Test Date 2 is not within the operating hourss for the tourist site");
        } else {
            NSLog(@"Test Date 2 is within the operating hours for the tourist site!");
            
            NSInteger timeUntilClosingInSeconds = [touristSiteODT timeUntilClosingInSeconds:testDate2];
            
            NSLog(@"The time until closing in seconds is %ld",(long)timeUntilClosingInSeconds);
        }
    }
    

    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}



-(void)viewDidLoad{
    [super viewDidLoad];
   
    UISwipeGestureRecognizer *showMenuGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    
    showMenuGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:showMenuGesture];
    
    CGRect desiredMenuFrame = CGRectMake(0.0, 0.0, 300.0, self.view.frame.size.height);
    self.menuComponent = [[MenuComponent alloc] initMenuWithFrame:desiredMenuFrame
                    targetView:self.view
                    direction:menuDirectionRightToLeft
                    options:@[@"About Hostel", @"Explore Nearby", @"Contact Info", @"Seoul Tourism",@"Weather",@"Survival Korean", @"Product Prices",@"Monitored Regions",@"Acknowledgements"]
                    optionImages:@[@"informationB", @"compassB", @"contactPhoneB", @"templeB",@"cloudyA",@"chatA", @"shoppingCartB",@"mapAddressB",@"trophyB"]];

}


- (void)showMenu:(UIGestureRecognizer *)gestureRecognizer {
    [self.menuComponent showMenuWithSelectionHandler:^(NSInteger selectedOptionIndex) {
        
        UIStoryboard* storyBoardA = [UIStoryboard storyboardWithName:@"StoryboardA" bundle:nil];
        
        UIStoryboard* storyBoardB = [UIStoryboard storyboardWithName:@"StoryboardB" bundle:nil];
        
        UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController* requestedViewController;
        
        switch (selectedOptionIndex) {
            case 0:
                //Information about hostel
                requestedViewController = [self getInformationControllerFromStoryBoard];
                NSLog(@"You selected option %d",(int)selectedOptionIndex);
                break;
            case 1:
                //Directions
                 requestedViewController = [storyBoardA instantiateViewControllerWithIdentifier:@"DirectionsMenuController"];
                    NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 2:
                //Contact info
                 requestedViewController = [storyBoardA instantiateViewControllerWithIdentifier:@"DirectionsMenuController"];
                    NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 3:
                //Seoul tourism
                 requestedViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SeoulTourismNavigationController"];
                    NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 4:
                //Weather
                 requestedViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"WeatherNavigationController"];
                NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 5:
                //Korean Phrases Audio
                break;
            case 6:
                //Korean Product Prices
                requestedViewController = [storyBoardB instantiateViewControllerWithIdentifier:@"ProductPriceNavigationController"];
                break;
            case 7:
                requestedViewController = [self getMonitoredRegionsControllerFromStoryboard];
                break;
            case 8:
                //Acknowledgements
                requestedViewController = [storyBoardA instantiateViewControllerWithIdentifier:@"DirectionsMenuController"];
                NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            default:
                break;
        }
        
        [self showViewController:requestedViewController sender:nil];

    }];
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [self.menuComponent resetMenuView:[self traitCollection]];
}


-(UIViewController*)getMonitoredRegionsControllerFromStoryboard{
    
    UIStoryboard* storyboardB = [UIStoryboard storyboardWithName:@"StoryboardB" bundle:nil];
    
    
    NSString *storyBoardIdentifier = @"MonitoredRegionsController_iPad";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        storyBoardIdentifier = @"MonitoredRegionsController";
    }
    
    
    return [storyboardB instantiateViewControllerWithIdentifier:storyBoardIdentifier];
    
}

-(UIViewController*)getInformationControllerFromStoryBoard{
    
    // decide which kind of content we need based on the device idiom,
    // when we load the proper storyboard, the "ContentController" class will take it from here
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    NSString *storyBoardIdentifier = @"PadInformationController";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        storyBoardIdentifier = @"PhoneInformationController";
    }
    
    
    return [mainStoryBoard instantiateViewControllerWithIdentifier:storyBoardIdentifier];
    
}


-(IBAction)unwindBackToHostelIndexPage:(UIStoryboardSegue *)unwindSegue{
    
}

@end
