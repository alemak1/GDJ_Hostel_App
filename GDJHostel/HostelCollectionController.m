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

@interface HostelCollectionController ()

@property (strong, nonatomic,readonly) NSArray *hostelImageNames;


@end

@implementation HostelCollectionController

-(void)viewWillAppear:(BOOL)animated{
    
    
   
    
}


-(void)viewDidLoad{

    [super viewDidLoad];
    ;
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    [self.collectionView registerClass:[HostelCollectionViewCell class] forCellWithReuseIdentifier:@"HostelCollectionViewCell"];

    [self.collectionView setContentSize:self.collectionView.frame.size];;
   
    NSLog(@"Collection view information: %@",[self.collectionView description]);
    
    //HostelFlowLayout *hostelFlowLayout = [[HostelFlowLayout alloc]init];

    //[self.collectionView setCollectionViewLayout:hostelFlowLayout animated:YES];

    UIGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];

    [self.collectionView addGestureRecognizer:pinchRecognizer];

}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)sender {
    
    // Get a reference to the flow layout
    
    HostelFlowLayout *layout =
    (HostelFlowLayout *)self.collectionView.collectionViewLayout;
    
    // If this is the start of the gesture
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        // Get the initial location of the pinch?
        CGPoint initialPinchPoint =
        [sender locationInView:self.collectionView];
        
        //Convert pinch location into a specific cell
        NSIndexPath *pinchedCellPath =
        [self.collectionView indexPathForItemAtPoint:initialPinchPoint];
        
        // Store the indexPath to cell
        layout.currentCellPath = pinchedCellPath;
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        // Store the new center location of the selected cell
        layout.currentCellCenter =
        [sender locationInView:self.collectionView];
        // Store the scale value
        layout.currentCellScale = sender.scale;
    }
    else
    {
        [self.collectionView performBatchUpdates:^{
            layout.currentCellPath = nil;
            layout.currentCellScale = 1.0;
        } completion:nil];
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"Total number of items in section: %d",[self.hostelImageNames count]);
    
    return [self.hostelImageNames count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HostelCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"HostelCollectionViewCell" forIndexPath:indexPath];
    
    NSLog(@"Cell dequeud with information: %@", [cell description]);
    
    NSString* imageName = [self.hostelImageNames objectAtIndex:indexPath.row];
    cell.hostelImage = [UIImage imageNamed:imageName];
    
    NSLog(@"Cell configured with image name: %@", imageName);
    
    return cell;
}


-(NSArray *)hostelImageNames{
    
    return @[@"RoomNo2_1",@"RoomNo2_2",@"RoomNo2_3",@"RoomNo2_4",@"RoomNo2_5",@"RoomNo2_6"];

}

@end
