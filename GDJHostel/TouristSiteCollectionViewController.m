//
//  TouristSiteCollectionViewController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/26/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "TouristSiteCollectionViewController.h"
#import "TouristSiteCollectionViewCell.h"
#import "UIView+HelperMethods.h"
#import "TouristSiteManager.h"

@interface TouristSiteCollectionViewController () <UICollectionViewDataSourcePrefetching>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (readonly) NSArray* debugImagePathArray;
@property TouristSiteManager* siteManager;

@end


@implementation TouristSiteCollectionViewController


@synthesize debugImagePathArray = _debugImagePathArray;



-(void)viewWillAppear:(BOOL)animated{
    
    
    self.siteManager = [[TouristSiteManager alloc] initWithFileName:@"SeoulTouristSites"];
    NSLog(@"Site manager debug info: %@",[self.siteManager abbreviatedDebugDescription]);
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView setPrefetchDataSource:self];
    
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    
}




-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 10;

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
      return 1;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TouristSiteCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"TouristCollectionViewCell" forIndexPath:indexPath];

    
    cell.backgroundColor = [UIColor orangeColor];
    [cell setSiteImage:[UIImage imageNamed:@"RoomNo2_1"]];
    cell.titleText = @"A great tourist site";
    return cell;
    
}



-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}



-(NSArray *)debugImagePathArrayAtIndexes:(NSIndexSet *)indexes{
    
    if(_debugImagePathArray == nil){
        _debugImagePathArray = [NSArray arrayWithObjects:@"RoomNo3_1",@"RoomNo3_2",@"RoomNo3_3",@"RoomNo3_4",@"RoomNo3_5",@"RoomNo3_6",@"RoomNo3_7", nil];
    }
    
    return _debugImagePathArray;
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(300, 200);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 20.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 20.0;
}



@end

/**
 
 -(instancetype)initWithTitleText:(NSString*)titleText{
 
 self = [self init];
 
 if(self){
 
 CGRect titleLabeFrame = [self.view getFrameAdjustedRelativeToContentViewWithXCoordOffset:0.0 andWithYCoordOffset:0.0 andWithWidthMultiplier:1.00 andWithHeightMultiplier:0.10];
 
 UILabel* titleLabel = [[UILabel alloc] initWithFrame:titleLabeFrame];
 
 [self setTitleLabel:titleLabel];
 
 [self.titleLabel setText:titleText];
 
 
 CGRect collectionViewFrame = [self.view getFrameAdjustedRelativeToContentViewWithXCoordOffset:0.00 andWithYCoordOffset:0.10 andWithWidthMultiplier:1.00 andWithHeightMultiplier:1.00];
 
 UICollectionViewFlowLayout* flowLayoutObject = [[UICollectionViewFlowLayout alloc] init];
 
 [flowLayoutObject setScrollDirection:UICollectionViewScrollDirectionHorizontal];
 [flowLayoutObject setItemSize:CGSizeMake(200, 100)];
 [flowLayoutObject setMinimumLineSpacing:20.0];
 [flowLayoutObject setMinimumInteritemSpacing:30.0];
 
 UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayoutObject];
 
 [self setCollectionView:collectionView];
 
 [self.view addSubview:self.titleLabel];
 [self.view addSubview:self.collectionView];
 
 [self.view setBackgroundColor:[UIColor yellowColor]];
 [self.collectionView setBackgroundColor:[UIColor blueColor]];
 
 
 }
 
 return self;
 }
 **/

