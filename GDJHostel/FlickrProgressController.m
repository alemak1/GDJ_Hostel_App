//
//  FlickrProgressController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/10/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "FlickrProgressController.h"
#import "SeoulFlickrSearchController.h"
#import "FlickrSearchResults.h"
#import "FlickrHelper.h"

@interface FlickrProgressController ()


@property NSMutableOrderedSet<FlickrSearchResults*>* searches;

@property (readonly) FlickrHelper* flickrHelper;


- (IBAction)performSearch:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end




@implementation FlickrProgressController

FlickrHelper* _flickrHelper;

-(void)viewDidLoad{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"showFlickrPhotosSegue"]){
        
        SeoulFlickSearchController* seoulFlickrSearchController = (SeoulFlickSearchController*)segue.destinationViewController;
        
        seoulFlickrSearchController.searches = self.searches;
        
        
    }
}

-(FlickrHelper *)flickrHelper{
    
    if(_flickrHelper == nil){
        _flickrHelper = [[FlickrHelper alloc] init];
    }
    
    return _flickrHelper;
}


- (IBAction)performSearch:(UIButton *)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        [self.flickrHelper searchFlickrForTerm:@"Korea" andWithCompletionHandler:^(FlickrSearchResults* results, NSError*error){
            
            if(error){
                NSLog(@"Error: an error occured while performing the search %@",[error localizedDescription]);
            }
            
            if(!results){
                NSLog(@"Error: no results obtained from search");
            }
            
            
            [self.searches insertObject:results atIndex:0];
            
            
            NSLog(@"The searches array for search term %@ contains FlickSearchResults %@",[[self.searches firstObject] searchTerm],[[self.searches firstObject] searchResults]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSLog(@"The searches array for search term %@ contains FlickSearchResults %@",[[self.searches firstObject] searchTerm],[[self.searches firstObject] searchResults]);
                
                
                [self performSegueWithIdentifier:@"showFlickrPhotosSegue" sender:nil];
                
                
                
            });
            
            
        }];
        
        
        
        
    });
    

    
    
}


@end
