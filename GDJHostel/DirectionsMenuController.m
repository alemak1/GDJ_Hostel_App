//
//  DirectionsMenuController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectionsMenuController.h"
#import "LocationSearchController.h"
#import "ToHostelDirectionsController.h"
#import "TouristLocationTableViewController.h"

/**
#import "TouristLocationSelectionNavigationController.h"
#import "TouristLocationTableViewController.h"
#import "HostelLocalAreaMapController.h"
**/

@interface DirectionsMenuController ()

typedef enum VALID_NEXT_VIEW_CONTROLLER{
    TOURIST_LOCATION_TABLEVIEW_CONTROLLER = 0,
    LOCATION_SEARCH_CONTROLLER,
    TO_HOSTEL_DIRECTIONS_CONTROLLER,
    HOSTEL_LOCAL_AREA_MAP_CONTROLLER,
    BIKING_JOGGING_ROUTE_CONTROLLER,
    POLYGON_NAVIGATION_CONTROLLER,
    LAST_VIEW_CONTROLLER,
}VALID_NEXT_VIEW_CONTROLLER;

@property (weak, nonatomic) IBOutlet UIImageView *selectionBarImage;
@property (readonly) CGFloat titleFontSize;
@property VALID_NEXT_VIEW_CONTROLLER currentNextViewController;

- (IBAction)dismissViewController:(id)sender;

- (IBAction)showSelectedViewController:(UIButton *)sender;


- (IBAction)unwindToDirectionsMenuController:(UIStoryboardSegue *)unwindSegue;

@end

@implementation DirectionsMenuController

@synthesize titleFontSize = _titleFontSize;

-(void)viewWillLayoutSubviews{
    
    [self.pickerControl setDelegate:self];
    [self.pickerControl setDataSource:self];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidLoad{
    
}

#pragma mark UIPICKER VIEW DELEGATE AND DATASOURCE METHODS

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    CGFloat componentWidth = self.selectionBarImage.bounds.size.width;
    
    return componentWidth;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    CGFloat rowHeight = self.selectionBarImage.bounds.size.height;
    
    return rowHeight;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return LAST_VIEW_CONTROLLER;
}



-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.currentNextViewController = (int)row;
}



-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    CGRect viewFrame = CGRectInset(self.selectionBarImage.frame, 1.0, 1.0);
    UILabel* label = [[UILabel alloc] initWithFrame:viewFrame];
    
    [label setNumberOfLines:0];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    NSString* mainText = [self getNextViewControllerTitleFor:(int)row];
    
    UIFont* primaryFont = [UIFont fontWithName:@"Futura-CondensedMedium" size:[self titleFontSize]];
    
    NSDictionary* stringAttributesDict = [NSDictionary dictionaryWithObjectsAndKeys:primaryFont,NSFontAttributeName, nil];
    
    NSMutableAttributedString* mainAttributedString = [[NSMutableAttributedString alloc] initWithString:mainText attributes:stringAttributesDict];
    
    label.attributedText = mainAttributedString;
    
    return label;
    
}


-(CGFloat)titleFontSize{
    
    if(!_titleFontSize){
    
        UITraitCollection *currentTraitCollection = [self traitCollection];
        UIUserInterfaceSizeClass horizontalSC = [currentTraitCollection horizontalSizeClass];
        UIUserInterfaceSizeClass verticalSC = [currentTraitCollection verticalSizeClass];
    
        BOOL CW_CH = (horizontalSC == UIUserInterfaceSizeClassCompact && verticalSC == UIUserInterfaceSizeClassCompact);
    
        BOOL CW_RH = (horizontalSC == UIUserInterfaceSizeClassCompact && verticalSC == UIUserInterfaceSizeClassRegular);
    
        BOOL RW_CH = (horizontalSC == UIUserInterfaceSizeClassRegular && verticalSC == UIUserInterfaceSizeClassCompact);
    
        BOOL RW_RH = (horizontalSC == UIUserInterfaceSizeClassRegular && verticalSC == UIUserInterfaceSizeClassRegular);
    
        _titleFontSize = 30.0;
        
        if(CW_CH){
            return 30.0;
        }
    
        if(CW_RH){
            return 30.0;
        }
    
        if(RW_CH){
            return 50.0;
        
        }
    
        if(RW_RH){
            return 50.0;
        }
    
    
    }
    
    return _titleFontSize;
}

- (IBAction)dismissViewController:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showSelectedViewController:(UIButton *)sender {
    
    UIViewController* nextViewController;
    
    UIStoryboard* storyBoardA = [UIStoryboard storyboardWithName:@"StoryboardA" bundle:nil];
    
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            
    switch (self.currentNextViewController) {
        case TOURIST_LOCATION_TABLEVIEW_CONTROLLER:
            nextViewController = [self getNavigationControllerForTouristLocationTableViewController];
            break;
        case TO_HOSTEL_DIRECTIONS_CONTROLLER:
            nextViewController = [storyBoardA instantiateViewControllerWithIdentifier:@"ToHostelDirectionsController"];
            break;
        case LOCATION_SEARCH_CONTROLLER:
            nextViewController = [storyBoardA instantiateViewControllerWithIdentifier:@"LocationSearchController"];
            break;
        case HOSTEL_LOCAL_AREA_MAP_CONTROLLER:
            nextViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"HostelAreaNavigationController"];
            break;
        case BIKING_JOGGING_ROUTE_CONTROLLER:
            nextViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"BikeRouteNavigationController"];
            break;
        case POLYGON_NAVIGATION_CONTROLLER:
            nextViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"PolygonNavigationController"];
            break;
        default:
            break;
    }
    
    [self showViewController:nextViewController sender:nil];
}

- (UINavigationController*) getNavigationControllerForTouristLocationTableViewController{
    
    
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:[[TouristLocationTableViewController alloc] init]];
    

    return navigationController;

    return nil;
}

-(NSString*)getNextViewControllerTitleFor:(VALID_NEXT_VIEW_CONTROLLER)validNextViewController{
    
    switch (validNextViewController) {
        case TO_HOSTEL_DIRECTIONS_CONTROLLER:
            return @"Route to Hostel";
        case TOURIST_LOCATION_TABLEVIEW_CONTROLLER:
            return @"List of Recommended Places";
        case LOCATION_SEARCH_CONTROLLER:
            return @"Search for Locations Nearby";
        case HOSTEL_LOCAL_AREA_MAP_CONTROLLER:
            return @"View the Local Area";
        case BIKING_JOGGING_ROUTE_CONTROLLER:
            return @"Local Biking/Jogging Routes";
        case POLYGON_NAVIGATION_CONTROLLER:
            return @"Local Building, Park, and Site Regions";
        case LAST_VIEW_CONTROLLER:
            return nil;
    }
    
    return nil;
}

- (IBAction)unwindToDirectionsMenuController:(UIStoryboardSegue *)unwindSegue
{
}

@end
