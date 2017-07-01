//
//  TouristSiteCategorySelectionController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/27/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristSiteCategorySelectionController.h"
#import "TouristSiteCollectionViewController.h"
#import "AppLocationManager.h"

@interface TouristSiteCategorySelectionController ()


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)returnToMainMenu:(UIBarButtonItem *)sender;



@end

@implementation TouristSiteCategorySelectionController


-(void)viewWillLayoutSubviews{
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    UserLocationManager* sharedLocationManager = [UserLocationManager sharedLocationManager];
    
    [sharedLocationManager requestAuthorizationAndStartUpdates];

    
    self.siteManager = [[TouristSiteManager alloc] initWithFileName:@"SeoulTouristSites"];
    
    [sharedLocationManager startMonitoringForRegions:[self.siteManager getRegionsForAllTouristLocations]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTSDetailInformationControllerForSelectedSite:) name:@"presentTouristSiteDetailNotification" object:nil];

    
}



-(void) pushTSDetailInformationControllerForSelectedSite:(NSNotification*)notification{
    
    TouristSiteConfiguration* selectedTouristConfiguration = [[notification userInfo] valueForKey:@"touristSiteConfiguration"];
    
   
    //Not yet implemented
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

-(void)viewDidLoad{
    
    
    CGFloat scrollViewWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat scrollViewHeight = CGRectGetHeight(self.scrollView.frame);
    
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth, scrollViewHeight*4.00);

    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    
    __block CGFloat controllerIndex = 0;
    
    CGFloat controllerHeight = scrollViewHeight*0.50;
    
    CGRect(^getControllerFrame)(void) = ^CGRect(void){
        
        CGRect frame = CGRectMake(0.00, controllerIndex*controllerHeight+controllerHeight*0.05, scrollViewWidth, controllerHeight);
        
        return frame;
    };
    
    
    
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    
    TouristSiteCollectionViewController* touristSiteCVC1 = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TouristSiteCollectionViewController"];
    
    [self addChildViewController:touristSiteCVC1];
    
    CGRect frame1 = getControllerFrame();
    
    [touristSiteCVC1.view setFrame:frame1];
    
    [self.scrollView addSubview:touristSiteCVC1.view];
    
    [touristSiteCVC1 didMoveToParentViewController:self];
    
    [touristSiteCVC1 setTitleLabelText:@"Seoul Tower"];
    
    [touristSiteCVC1 setCategory:SEOUL_TOWER];
    
    controllerIndex++;
    
    
    //Configure the next view controller...
    
    TouristSiteCollectionViewController* touristSiteCVC2 = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TouristSiteCollectionViewController"];
    
    [self addChildViewController:touristSiteCVC2];

    CGRect frame2 = getControllerFrame();
    
    [touristSiteCVC2.view setFrame:frame2];
    
    [self.scrollView addSubview:touristSiteCVC2.view];
    
    [touristSiteCVC2 didMoveToParentViewController:self];
    
    [touristSiteCVC2 setTitleLabelText:@"Parks and Other Natural Sites"];

    [touristSiteCVC2 setCategory:PARK];
    
    controllerIndex++;
    
    
    //Configure the next view controller...
    
    
    TouristSiteCollectionViewController* touristSiteCVC3 = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TouristSiteCollectionViewController"];
    
    [self addChildViewController:touristSiteCVC3];

    CGRect frame3 = getControllerFrame();
    
    [touristSiteCVC3.view setFrame:frame3];

    [self.scrollView addSubview:touristSiteCVC3.view];
    
    [touristSiteCVC3 didMoveToParentViewController:self];
    
    [touristSiteCVC3 setTitleLabelText:@"Temples and Other Monuments"];
    
    [touristSiteCVC3 setCategory:MONUMENT_OR_WAR_MEMORIAL];

    
    controllerIndex++;
    
    //Configure the next view controller...
    
    TouristSiteCollectionViewController* touristSiteCVC4 = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TouristSiteCollectionViewController"];
    
    [self addChildViewController:touristSiteCVC4];
    
    
    CGRect frame4 = getControllerFrame();
    
    [touristSiteCVC4.view setFrame:frame4];
    
    [self.scrollView addSubview:touristSiteCVC4.view];
    
    [touristSiteCVC4 didMoveToParentViewController:self];
    
    [touristSiteCVC4 setTitleLabelText:@"Shopping Centers"];
    
    [touristSiteCVC4 setCategory:SHOPPING_AREA];
    
    controllerIndex++;
    
    //Configure the next view controller...
    
    TouristSiteCollectionViewController* touristSiteCVC5 = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TouristSiteCollectionViewController"];
    
    [self addChildViewController:touristSiteCVC5];
    
    
    CGRect frame5 = getControllerFrame();
    
    [touristSiteCVC5.view setFrame:frame5];
    
    [self.scrollView addSubview:touristSiteCVC5.view];
    
    [touristSiteCVC5 didMoveToParentViewController:self];
    
    [touristSiteCVC5 setTitleLabelText:@"Yanggu County"];
    
    [touristSiteCVC5 setCategory:YANGGU_COUNTY];
    
    controllerIndex++;
    
    //Configure the next view controller...
    
    TouristSiteCollectionViewController* touristSiteCVC6 = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TouristSiteCollectionViewController"];
    
    [self addChildViewController:touristSiteCVC6];
    
    
    CGRect frame6 = getControllerFrame();
    
    [touristSiteCVC6.view setFrame:frame6];
    
    [self.scrollView addSubview:touristSiteCVC6.view];
    
    [touristSiteCVC6 didMoveToParentViewController:self];
    
    [touristSiteCVC6 setTitleLabelText:@"Museums and Other"];
    
    [touristSiteCVC6 setCategory:OTHER];
    
    controllerIndex++;
    
    




    
}


- (IBAction)returnToMainMenu:(UIBarButtonItem *)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

@end
