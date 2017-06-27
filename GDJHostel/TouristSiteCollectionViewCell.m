//
//  TouristSiteCollectionViewCell.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristSiteCollectionViewCell.h"
#import "UIView+HelperMethods.h"

@interface TouristSiteCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *siteImageView;

@property (weak, nonatomic) IBOutlet UIButton *getRouteButton;


@property (weak, nonatomic) IBOutlet UIButton *getDetailsButton;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *travelTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

//Each tourist site cell has detail and directions buttons that perform segues whose string identifiers are configured to match tourist site names or ids; the view controllers that are presented modally can be configured in the storyboard and instantiated using the segue identifiers; tourist site detail and location information can be passed to the dstinationed view controller through the segue; in the prepare for segue method, set exposed properties (corresponding to site location and details) in the prepare for segue method

- (IBAction)getDirectionsForTouristSite:(id)sender;

- (IBAction)getDetailsForTouristSite:(id)sender;

//TODO: Add tap gesture recognizers to these labels so that they call the same methods as their corresponding buttons
@property (weak, nonatomic) IBOutlet UILabel *directionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;


@end



@implementation TouristSiteCollectionViewCell





/** Implement getters and setters for labels and image view **/



-(void)setTitleText:(NSString *)titleText{
    [self.titleLabel setText:titleText];
    [self layoutIfNeeded];
}

-(NSString *)titleText{
    return [self.titleLabel text];
}

-(void)setSiteImage:(UIImage *)siteImage{
    
    [self.siteImageView setImage:siteImage];
    [self layoutIfNeeded];
}

-(UIImage *)siteImage{
    
    return [self.siteImageView image];
}

- (IBAction)getDirectionsForTouristSite:(id)sender {
    
    //Make  request in maps to get the directions to the site
}

- (IBAction)getDetailsForTouristSite:(id)sender {
    
    /** Since this collection view cell is a subview of a collecion view that is being managed by a viewcontroller, which in turn is a child view controller for paret view contrller that is the root view of a navigation controller, posting notification is best option to  transfer data **/
    
    //Send notification and pass data so that the TouristCategorySelectionController's navigation controller can present the detail controller
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"presentTouristSiteDetailNotification" object:self userInfo:nil];
}



@end
