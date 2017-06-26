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

@end
