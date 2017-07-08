//
//  SeoulFlickrSearchController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeoulFlickrSearchController.h"
#import "FlickrPhoto.h"
#import "FlickrSearchResults.h"
#import "FlickrHelper.h"

@interface SeoulFlickSearchController () <UICollectionViewDelegateFlowLayout>

@property NSMutableArray<FlickSearchResults*>* searches;
@property (readonly) FlickrHelper* flickrHelper;

@end

@implementation SeoulFlickSearchController

FlickrHelper* _flickrHelper;

-(void)viewDidLoad{
    
    
    NSLog(@"Flickr Helper Debug Info %@",[self.flickrHelper description]);
}



-(FlickrPhoto*)photoForIndexPath:(NSIndexPath*)indexPath{
    return [[self.searches objectAtIndex:indexPath.section].searchResults objectAtIndex:indexPath.row];
}

-(FlickrHelper *)flickrHelper{
    if(_flickrHelper == nil){
        _flickrHelper = [[FlickrHelper alloc] init];
    }
    
    return _flickrHelper;
}


#pragma mark COLLECTIONVIEW DATASOURCE METHODS

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.searches count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [[self.searches objectAtIndex:section].searchResults count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}


#pragma mark COLLECTIONVIEW DELEGATE METHODS 

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(200, 300);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 30;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 20, 20, 10);
}


@end
