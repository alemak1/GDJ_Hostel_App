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


@property UIButton* getRouteButton;
@property UIButton* seeDetailsButton;

@property UIImageView* siteImageView;
@property UILabel* titleLabel;
@property UILabel* distanceFromUserLabel;
@property UILabel* travelingTimeLabel;

@end

@implementation TouristSiteCollectionViewCell

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        _siteImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [_siteImageView setContentMode:UIViewContentModeScaleAspectFill];
        
        [self.contentView addSubview:_siteImageView];
        
        CGRect titleFrame = [self getFrameAdjustedRelativeToContentViewWithXCoordOffset:0.05 andWithYCoordOffset:0.05 andWithWidthMultiplier:0.5 andWithHeightMultiplier:0.30];
        
        _titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
        
        //TODO: Additional configuration for the label....
        //...
        //...
        //...
        //...   TODO: Set Label Text
        
        [self.contentView addSubview:_titleLabel];
        
        
        CGRect distanceLabelFrame = [self getFrameAdjustedRelativeToContentViewWithXCoordOffset:.05 andWithYCoordOffset:0.30 andWithWidthMultiplier:0.20 andWithHeightMultiplier:0.20];
        _distanceFromUserLabel = [[UILabel alloc] initWithFrame:distanceLabelFrame];
        
        //TODO: Additional configuration for the label...
        
        [self.contentView addSubview:_distanceFromUserLabel];
        
        CGRect travelingTimeLabelFrame = [self getFrameAdjustedRelativeToContentViewWithXCoordOffset:.05 andWithYCoordOffset:0.50 andWithWidthMultiplier:0.20 andWithHeightMultiplier:0.20];
        _travelingTimeLabel = [[UILabel alloc] initWithFrame:travelingTimeLabelFrame];
        
        //TODO: Additional configuration for the label...
        //....
        //...
        //....
        //...
        
        [self.contentView addSubview:_travelingTimeLabel];
        
        
        CGRect routeButtonFrame = [self getFrameAdjustedRelativeToContentViewWithXCoordOffset:0.25 andWithYCoordOffset:0.30 andWithWidthMultiplier:0.20 andWithHeightMultiplier:0.20];
        
        //TODO: Additional configuration for the button...
        //....
        //...
        //....
        
        _getRouteButton = [[UIButton alloc] initWithFrame:routeButtonFrame];
        
        [self.contentView addSubview:_getRouteButton];

        
        CGRect detailsButtonFrame = [self getFrameAdjustedRelativeToContentViewWithXCoordOffset:0.25 andWithYCoordOffset:0.50 andWithWidthMultiplier:0.20 andWithHeightMultiplier:0.20];
        
        _seeDetailsButton = [[UIButton alloc] initWithFrame:detailsButtonFrame];
        
        //TODO: Additional configuration for the button....
        //....
        //....
        //...
        
        [self.contentView addSubview:_seeDetailsButton];

    
    }
    
    return self;
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
