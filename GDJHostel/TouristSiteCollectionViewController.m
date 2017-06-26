//
//  TouristSiteCollectionViewController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/26/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "TouristSiteCollectionViewController.h"
#import "TouristSiteCollectionViewCell.h"

@interface TouristSiteCollectionViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewTop;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewMidTop;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewMidBottom;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewBottom;


@property (readonly) NSArray* debugImagePathArray;

@end


@implementation TouristSiteCollectionViewController


@synthesize debugImagePathArray = _debugImagePathArray;

-(void)viewWillLayoutSubviews{
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.collectionViewTop setDelegate:self];
    [self.collectionViewTop setDataSource:self];
    
    [self.collectionViewMidTop setDataSource:self];
    [self.collectionViewMidTop setDelegate:self];
    
    [self.collectionViewMidBottom setDelegate:self];
    [self.collectionViewMidBottom setDataSource:self];
    
    [self.collectionViewBottom setDataSource:self];
    [self.collectionViewBottom setDelegate:self];
    
    [self.collectionViewTop registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"TouristCollectionViewCell"];
    [self.collectionViewMidTop registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"TouristCollectionViewCell"];
    [self.collectionViewMidBottom registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"TouristCollectionViewCell"];
    [self.collectionViewBottom registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"TouristCollectionViewCell"];
}


-(void)viewDidAppear:(BOOL)animated{
    
    
}

-(void)viewDidLoad{
    
    
    NSLog(@"Collection View Top: %@",[self.collectionViewTop description]);
    NSLog(@"Collection View MidTop: %@",[self.collectionViewMidTop description]);
    NSLog(@"Collection View MidBottom: %@",[self.collectionViewMidBottom description]);
    NSLog(@"Collection View Bottom: %@",[self.collectionViewBottom description]);


    [self.collectionViewTop reloadData];
    
    [self.collectionViewMidTop reloadData];
    
    [self.collectionViewBottom reloadData];

    [self.collectionViewBottom reloadData];

    /** The containing view controller will act as both data source and delegate for all of the collection views in the view hierarchy; each collection view is distinguished by its tag identifier  **/
   
    
    /**
    [self.collectionView registerClass:[TouristSiteCollectionViewCell class] forCellWithReuseIdentifier:@"TouristSiteCollectionViewCell"];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"DefaultCell"];
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
     **/
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    switch (collectionView.tag) {
        case 1:
            return [self.debugImagePathArray count];
        case 2:
            return [self.debugImagePathArray count];
        case 3:
            return [self.debugImagePathArray count];
        case 4:
            return [self.debugImagePathArray count];
        default:
            break;
    }
    
    return 10;

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    switch (collectionView.tag) {
        case 1:
            return 1;
        case 2:
            return 1;
        case 3:
            return 1;
        case 4:
            return 1;
        default:
            break;
    }
    
    return 1;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TouristSiteCollectionViewCell* cell;
    
    switch (collectionView.tag) {
        case 1:
            cell = [self.collectionViewTop dequeueReusableCellWithReuseIdentifier:@"TouristCollectionViewCell" forIndexPath:indexPath];
            break;
        case 2:
            cell = [self.collectionViewMidTop dequeueReusableCellWithReuseIdentifier:@"TouristCollectionViewCell" forIndexPath:indexPath];
            break;
        case 3:
            cell = [self.collectionViewMidBottom dequeueReusableCellWithReuseIdentifier:@"TouristCollectionViewCell" forIndexPath:indexPath];
            break;
        case 4:
            cell = [self.collectionViewBottom dequeueReusableCellWithReuseIdentifier:@"TouristCollectionViewCell" forIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    cell.siteImage = [UIImage imageNamed:@"RoomNo3_1"];
    cell.titleText = @"Great Room";
    cell.backgroundColor = [UIColor orangeColor];
    
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

/**

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(200, 100);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 40.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 30.0;
}

**/

@end
