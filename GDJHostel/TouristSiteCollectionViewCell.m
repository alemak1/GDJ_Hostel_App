//
//  TouristSiteCollectionViewCell.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristSiteCollectionViewCell.h"

@interface TouristSiteCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *siteImageView;

@property (weak, nonatomic) IBOutlet UIButton *getRouteButton;


@property (weak, nonatomic) IBOutlet UIButton *getDetailsButton;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *travelTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;



@end

@implementation TouristSiteCollectionViewCell

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        self.siteImageView.image = self.siteImage;
        self.titleLabel.text = self.titleText;
        
    
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.siteImageView.image = self.siteImage;
    self.titleLabel.text = self.titleText;
    
    
    
}

-(CGRect) getFrameAdjustedRelativeToContentViewWithXCoordOffset:(CGFloat)xCoordinateOffset andWithYCoordOffset:(CGFloat)yCoordinateOffset andWithWidthMultiplier:(CGFloat)widthMultiplier andWithHeightMultiplier:(CGFloat)heightMultiplier{
    
    CGFloat contentViewWidth = CGRectGetWidth(self.contentView.frame);
    CGFloat contentViewHeight = CGRectGetHeight(self.contentView.frame);
    
    CGRect contentViewFrame = self.contentView.frame;
    
    contentViewFrame.origin.x = contentViewWidth*xCoordinateOffset;
    contentViewFrame.origin.y = contentViewHeight*yCoordinateOffset;
    contentViewFrame.size = CGSizeMake(contentViewWidth*widthMultiplier, contentViewHeight*heightMultiplier);
    
    return contentViewFrame;
}

@end
