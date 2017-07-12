//
//  HostelCollectionController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostelCollectionController.h"
#import "HostelFlowLayout.h"
#import "HostelCollectionViewCell.h"
#import "ImageManagerB.h"
#import "ImageKeyConstants.h"

@interface HostelCollectionController ()

@property (strong, nonatomic,readonly) NSArray *roomNo1_imageNames;
@property (strong, nonatomic,readonly) NSArray *roomNo2_imageNames;
@property (strong, nonatomic,readonly) NSArray *roomNo3_imageNames;
@property (strong, nonatomic,readonly) NSArray *roomNo4_imageNames;

@property NSOperation* preloadOperationForRoomNo1;
@property NSOperation* preloadOperationForRoomNo2;
@property NSOperation* preloadOperationForRoomNo3;
@property NSOperation* preloadOperationForRoomNo4;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewTop;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewMidTop;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewMidBottom;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewBottom;




@end



@implementation HostelCollectionController

-(void)viewWillAppear:(BOOL)animated{
    
    
    
}


-(void)viewDidLoad{

    [super viewDidLoad];
    ;
    
    [self.collectionViewTop setDelegate:self];
    [self.collectionViewTop setDataSource:self];
    [self.collectionViewTop setPrefetchDataSource:self];
    [self.collectionViewTop registerClass:[HostelCollectionViewCell class] forCellWithReuseIdentifier:@"TopCollectionViewCell"];
    
    [self.collectionViewMidTop setDelegate:self];
    [self.collectionViewMidTop setDataSource:self];
    [self.collectionViewMidTop setPrefetchDataSource:self];
    [self.collectionViewMidTop registerClass:[HostelCollectionViewCell class] forCellWithReuseIdentifier:@"MidTopCollectionViewCell"];
    
    
    [self.collectionViewMidBottom setDataSource:self];
    [self.collectionViewMidBottom setDelegate:self];
    [self.collectionViewMidBottom setPrefetchDataSource:self];
    [self.collectionViewMidBottom registerClass:[HostelCollectionViewCell class] forCellWithReuseIdentifier:@"MidBottomCollectionViewCell"];
    
    [self.collectionViewBottom setDelegate:self];
    [self.collectionViewBottom setDataSource:self];
    [self.collectionViewBottom setPrefetchDataSource:self];
    [self.collectionViewBottom registerClass:[HostelCollectionViewCell class] forCellWithReuseIdentifier:@"BottomCollectionViewCell"];
    
  
   

}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)sender {
    
    // Get a reference to the flow layout
    
    HostelFlowLayout *layout =
    (HostelFlowLayout *)self.collectionViewTop.collectionViewLayout;
    
    // If this is the start of the gesture
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        // Get the initial location of the pinch?
        CGPoint initialPinchPoint =
        [sender locationInView:self.collectionViewTop];
        
        //Convert pinch location into a specific cell
        NSIndexPath *pinchedCellPath =
        [self.collectionViewTop indexPathForItemAtPoint:initialPinchPoint];
        
        // Store the indexPath to cell
        layout.currentCellPath = pinchedCellPath;
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        // Store the new center location of the selected cell
        layout.currentCellCenter =
        [sender locationInView:self.collectionViewTop];
        // Store the scale value
        layout.currentCellScale = sender.scale;
    }
    else
    {
        [self.collectionViewTop performBatchUpdates:^{
            layout.currentCellPath = nil;
            layout.currentCellScale = 1.0;
        } completion:nil];
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    switch (collectionView.tag) {
        case 11:
            //Debug only: return [self.roomNo1_imageNames count];
            return [[ImageManagerB sharedManager] getNumberOfItemsInSection:ROOM_NO1];
        case 12:
            //Debug only: return [self.roomNo2_imageNames count];
           return [[ImageManagerB sharedManager] getNumberOfItemsInSection:ROOM_NO2];
        case 13:
           //Debug only: return [self.roomNo3_imageNames count];
            return [[ImageManagerB sharedManager] getNumberOfItemsInSection:ROOM_NO3];
        case 14:
           //Debug only: return [self.roomNo4_imageNames count];

            return [[ImageManagerB sharedManager] getNumberOfItemsInSection:ROOM_NO4];
        default:
            return 1;
    }
    
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HostelCollectionViewCell* cell;

    switch (collectionView.tag) {
        case 11:
            cell = [self.collectionViewTop dequeueReusableCellWithReuseIdentifier:@"TopCollectionViewCell" forIndexPath:indexPath];
            break;
        case 12:
            cell = [self.collectionViewMidTop dequeueReusableCellWithReuseIdentifier:@"MidTopCollectionViewCell" forIndexPath:indexPath];
            break;
        case 13:
             cell = [self.collectionViewMidBottom dequeueReusableCellWithReuseIdentifier:@"MidBottomCollectionViewCell" forIndexPath:indexPath];
            break;
        case 14:
            cell = [self.collectionViewBottom dequeueReusableCellWithReuseIdentifier:@"BottomCollectionViewCell" forIndexPath:indexPath];
            break;
        default:
            return [[HostelCollectionViewCell alloc] init];
    }
    


    UIImage* cellImage;
    NSString* imageName;
    
        switch (collectionView.tag) {
            case 11:
                
                    imageName = [self.roomNo1_imageNames objectAtIndex:indexPath.row];
                    
                    cellImage = [self.preloadOperationForRoomNo1 isFinished] ? [[ImageManagerB sharedManager] getImageForIndexPath:indexPath] : [UIImage imageNamed:imageName];
                  
                    //Debug only: cellImage = [UIImage imageNamed:imageName];
            
                break;
            case 12:
                
                    imageName = [self.roomNo2_imageNames objectAtIndex:indexPath.row];
                    
                    cellImage = [self.preloadOperationForRoomNo2 isFinished] ? [[ImageManagerB sharedManager] getImageForIndexPath:indexPath] : [UIImage imageNamed:imageName];
                    
                    //Debug only: cellImage = [UIImage imageNamed:imageName];

                
                break;
            case 13:
                
                    imageName = [self.roomNo3_imageNames objectAtIndex:indexPath.row];
                    
                    cellImage = [self.preloadOperationForRoomNo3 isFinished] ? [[ImageManagerB sharedManager] getImageForIndexPath:indexPath] : [UIImage imageNamed:imageName];
                    
                    //Debug only: cellImage = [UIImage imageNamed:imageName];

                
                break;
            case 14:
                
                    imageName = [self.roomNo4_imageNames objectAtIndex:indexPath.row];
                    
                    cellImage = [self.preloadOperationForRoomNo4 isFinished] ? [[ImageManagerB sharedManager] getImageForIndexPath:indexPath] : [UIImage imageNamed:imageName];
                    
                    //Debug only: cellImage = [UIImage imageNamed:imageName];

                
                break;
            default:
                cellImage = nil;
        }

    if(cellImage == nil){
        return cell;
    }
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:cell.contentView.frame];
    imageView.image = cellImage;

    [cell.contentView addSubview:imageView];
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    
        for (NSIndexPath* indexPath in indexPaths) {
            
            switch (indexPath.section) {
                case 0:
                    self.preloadOperationForRoomNo1 = [NSBlockOperation blockOperationWithBlock:^{

                    [[ImageManagerB sharedManager] loadImageForRoomNo1];
                    }];
                    
                    [self.preloadOperationForRoomNo1 setQueuePriority:NSOperationQueuePriorityNormal];
                    
                    [self.preloadOperationForRoomNo1 start];
                    
                    break;
                case 1:
                    self.preloadOperationForRoomNo2 = [NSBlockOperation blockOperationWithBlock:^{
                        
                        [[ImageManagerB sharedManager] loadImageForRoomNo2];
                    }];
                    
                    [self.preloadOperationForRoomNo2 setQueuePriority:NSOperationQueuePriorityNormal];
                    
                    [self.preloadOperationForRoomNo2 start];
                    
                    break;
                case 2:
                    self.preloadOperationForRoomNo3 = [NSBlockOperation blockOperationWithBlock:^{
                        
                        [[ImageManagerB sharedManager] loadImageForRoomNo3];
                    }];
                    
                    [self.preloadOperationForRoomNo3 setQueuePriority:NSOperationQueuePriorityNormal];
                    
                    [self.preloadOperationForRoomNo3 start];
                    
                case 3:
                    self.preloadOperationForRoomNo4 = [NSBlockOperation blockOperationWithBlock:^{
                        
                        [[ImageManagerB sharedManager] loadImageForRoomNo4];
                    }];
                    
                    [self.preloadOperationForRoomNo4 setQueuePriority:NSOperationQueuePriorityNormal];

                    [self.preloadOperationForRoomNo4 start];
                    
                default:
                    break;
            }
            
        }

    
    
    
    
}

-(void)collectionView:(UICollectionView *)collectionView cancelPrefetchingForItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    
    for (NSIndexPath* indexPath in indexPaths) {
        
        switch (indexPath.section) {
            case 0:
                [self.preloadOperationForRoomNo1 cancel];
                [[ImageManagerB sharedManager] unloadImagesForRoomNo1];
                break;
            case 1:
                [self.preloadOperationForRoomNo2 cancel];
                [[ImageManagerB sharedManager] unloadImagesForRoomNo2];

                break;
            case 2:
                [self.preloadOperationForRoomNo3 cancel];
                [[ImageManagerB sharedManager] unloadImagesForRoomNo3];

                break;
            case 3:
                [self.preloadOperationForRoomNo4 cancel];
                [[ImageManagerB sharedManager] unloadImagesForRoomNo4];

                break;
            default:
                break;
        }
        
    }

    
}



-(NSArray *)roomNo1_imageNames{
    
    return @[kRoomNo1_1,kRoomNo1_2,kRoomNo1_3,kRoomNo1_4,kRoomNo1_5];

}

-(NSArray *)roomNo2_imageNames{
    
    return @[kRoomNo2_1,kRoomNo2_2,kRoomNo2_3,kRoomNo2_4];

    
}

-(NSArray *)roomNo3_imageNames{
    
    return @[kRoomNo3_1,kRoomNo3_2,kRoomNo3_3,kRoomNo3_4,kRoomNo3_5,kRoomNo3_6,kRoomNo3_7,kRoomNo3_8,kRoomNo3_9,kRoomNo3_10,kRoomNo3_11,kRoomNo3_12];
    
}

-(NSArray *)roomNo4_imageNames{
    
    return @[kRoomNo4_1,kRoomNo4_2,kRoomNo4_3,kRoomNo4_4,kRoomNo4_5,kRoomNo4_6,kRoomNo4_7,kRoomNo4_8,kRoomNo4_9,kRoomNo4_10,kRoomNo4_11,kRoomNo4_12];
    
}

@end
