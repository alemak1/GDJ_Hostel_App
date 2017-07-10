//
//  FlickrProgressController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/10/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FlickrProgressController.h"
#import "SeoulFlickrSearchController.h"
#import "FlickrSearchResults.h"
#import "FlickrHelper.h"

@interface FlickrProgressController ()


@property FlickrSearchResults* searchResults;

@property (readonly) FlickrHelper* flickrHelper;


- (IBAction)performSearch:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end




@implementation FlickrProgressController

FlickrHelper* _flickrHelper;

-(void)viewDidLoad{
 
    [self.activityIndicator setHidden:YES];
    [self.activityIndicator setHidesWhenStopped:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"showFlickrPhotosSegue"]){
        
        
        
        SeoulFlickSearchController* seoulFlickrSearchController = (SeoulFlickSearchController*)segue.destinationViewController;
        
        NSLog(@"Preparing for segue to SeoulFlickrSearchController....");
        
        
        NSLog(@"The search results stored in the FlickProgressController is %@",[self.searchResults description]);
        
        seoulFlickrSearchController.searchResults = self.searchResults;
        
        
    }
}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if([identifier isEqualToString:@"showFlickrPhotosSegue"]){
     
        if(self.searchResults == nil){
            return NO;
        }
    }
    
    return YES;
}

-(FlickrHelper *)flickrHelper{
    
    if(_flickrHelper == nil){
        _flickrHelper = [[FlickrHelper alloc] init];
    }
    
    return _flickrHelper;
}


- (IBAction)performSearch:(UIButton *)sender {
    
    NSLog(@"About to perform search....");
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.activityIndicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        

      
        
        [self.flickrHelper searchFlickrForTerm:@"k-pop" andWithCompletionHandler:^(FlickrSearchResults* results, NSError*error){
            
            if(error){
                NSLog(@"Error: an error occured while performing the search %@",[error localizedDescription]);
            }
            
            if(!results){
                NSLog(@"Error: no results obtained from search");
            }
            
            
            self.searchResults = results;
            
            NSLog(@"The search results stored in the FlickProgressController is %@",[self.searchResults description]);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
               
                [self.activityIndicator stopAnimating];
                
                [self performSegueWithIdentifier:@"showFlickrPhotosSegue" sender:nil];
                
                
                
            });
            
            
        }];
        
        
        
        
    });
    
    
    
    
}


@end
