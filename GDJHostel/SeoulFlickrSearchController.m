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
#import "FlickrPhotoCell.h"

@interface SeoulFlickSearchController () <UICollectionViewDelegateFlowLayout>

@property NSMutableOrderedSet<FlickrSearchResults*>* searches;
@property (readonly) FlickrHelper* flickrHelper;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *seeNextImageGallery;

@property NSInteger searchIndex;

- (IBAction)getNextGallery:(UIBarButtonItem *)sender;


@end

@implementation SeoulFlickSearchController

FlickrHelper* _flickrHelper;


-(void)viewWillLayoutSubviews{
    
    self.searches = [[NSMutableOrderedSet alloc] init];
    self.searchIndex = 0;
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    
}


-(void)viewDidLoad{
  
    
    
    
    
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
    
    NSLog(@"Getting cell for collection view...");
    
    FlickrPhotoCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrPhotoCell" forIndexPath:indexPath];
    
    FlickrPhoto* flickrPhoto = [self photoForIndexPath:indexPath];
    

    cell.imageView.image = flickrPhoto.thumbnail;
    
    
    cell.backgroundColor = [UIColor blueColor];
    
    return cell;
}


#pragma mark COLLECTIONVIEW DELEGATE METHODS 

/**
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(200, 300);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 30;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 20, 20, 10);
}
**/

- (IBAction)getNextGallery:(UIBarButtonItem *)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        [self.flickrHelper searchFlickrForTerm:@"Korea" andWithCompletionHandler:^(FlickrSearchResults* results, NSError*error){
            
            if(error){
                NSLog(@"Error: an error occured while performing the search %@",[error localizedDescription]);
            }
            
            if(!results){
                NSLog(@"Error: no results obtained from search");
            }
            
            
            [self.searches insertObject:results atIndex:self.searchIndex];
            
            self.searchIndex++;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                [self.collectionView reloadData];
                
                
              
            });
        
            
        }];
        
        
        
        
    });
    
    

}


@end


/**
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 
 
 [self.flickrHelper searchFlickrForTerm:@"kimchi" andWithCompletionHandler:^(FlickSearchResults* results, NSError*error){
 
 if(error){
 NSLog(@"An error occured while performing the search %@",error);
 }
 
 if(!results){
 NSLog(@"No results obtained from search");
 }
 
 NSLog(@"Flickr search results info %@",[results description]);
 
 [self.searches addObject:results];
 
 
 NSInteger numberOfSections = [self.searches count];
 
 NSInteger numberOfRowsInSection1 = [[self.searches objectAtIndex:0].searchResults count];
 
 NSLog(@"Number of Sections %d, Number of rows in section 1 is %d",numberOfSections,numberOfRowsInSection1);
 
 }];
 
 
 
 dispatch_async(dispatch_get_main_queue(), ^{
 
 NSLog(@"Reloading collection view...");
 [self.collectionView reloadData];
 
 });
 
 });
 **/

/**
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 6*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
 
 NSLog(@"Reloading collection view...");
 
 [self.collectionView reloadData];
 
 for (FlickSearchResults*searchResults in self.searches) {
 
 for(FlickrPhoto*photo in searchResults.searchResults){
 NSLog(@"Flickr photo info %@",[photo description]);
 
 NSURL*photoURL = [photo getFlickrImageURLWithSize:@"m"];
 
 NSLog(@"The URL for this photo is %@",[photoURL absoluteString]);
 
 
 }
 }
 });
 **/

