//
//  FlickrHelper.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/10/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


#import "FlickrHelper.h"
#import "FlickrSearchResults.h"


@interface FlickrHelper ()


@property (readonly) NSString* flickrAPI;
@property (readonly) NSString* flickrSecretCode;

@property (readonly) NSOperationQueue* operationQueue;

@end

@implementation FlickrHelper

NSOperationQueue* _operationQueue;

-(void)searchFlickrForTerm:(NSString*)searchTerm andWithCompletionHandler:(void(^)(FlickrSearchResults* flickrSearchResults, NSError*error))completion{
    
    
    NSURL* searchURL = [self getFlickrSearchURLForSearchTerm:searchTerm];
    
    if(searchURL == nil){
        
        NSError* apiError = [NSError errorWithDomain:@"FlickrSearch" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Unknown API response",NSLocalizedFailureReasonErrorKey, nil]];
        
        
        completion(nil,apiError);
        
    } else {
        
        NSURLRequest* searchRequest = [NSURLRequest requestWithURL:searchURL];
        
        NSURLSession* sharedSession = [NSURLSession sharedSession];
        
        [[sharedSession dataTaskWithRequest:searchRequest completionHandler:^(NSData*data, NSURLResponse*response, NSError*error){
            
            
            if(error){
                NSError* apiError = [NSError errorWithDomain:@"FlickrSearch" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Unknown API respons",NSLocalizedFailureReasonErrorKey, nil]];
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completion(nil,apiError);
                }];
                
                return;
                
                
            }
            
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            
            if(!data || !httpResponse){
                NSError* apiError = [NSError errorWithDomain:@"FlickrSearch" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Unknown API respons",NSLocalizedFailureReasonErrorKey, nil]];
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completion(nil,apiError);
                }];
                
                return;
            }
            
            @try {
                
                NSError* error;
                
                NSDictionary* resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                
                
                NSString* stat = [resultsDictionary valueForKey:@"stat"];
                
                if(!stat || error){
                    NSError* apiError = [NSError errorWithDomain:@"FlickrSearch" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Unknown API respons",NSLocalizedFailureReasonErrorKey, nil]];
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completion(nil,apiError);
                    }];
                    
                    
                }
                
                /** Check the status message in the api response and perform any necessary error handling **/
                if([stat isEqualToString:@"ok"]){
                    
                    NSLog(@"Results processed okay");
                    
                } else if([stat isEqualToString:@"fail"]){
                    
                    NSString* message = [resultsDictionary valueForKey:@"message"];
                    
                    if(message){
                        
                        
                        NSError* apiError = [NSError errorWithDomain:@"FlickrSearch" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:message,NSLocalizedFailureReasonErrorKey, nil]];
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            completion(nil,apiError);
                        }];
                        
                        
                        return;
                    }
                    
                    NSError* apiError = [NSError errorWithDomain:@"FlickrSearch" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Unknown API respons",NSLocalizedFailureReasonErrorKey, nil]];
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completion(nil,apiError);
                    }];
                    
                } else {
                    
                    NSError* apiError = [NSError errorWithDomain:@"FlickrSearch" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Unknown API respons",NSLocalizedFailureReasonErrorKey, nil]];
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completion(nil,apiError);
                    }];
                    
                }
                
                NSDictionary* photosContainer = [resultsDictionary valueForKey:@"photos"];
                
                
                NSArray* photosReceived = [photosContainer valueForKey:@"photo"];
                
                
                if(!photosContainer || !photosReceived){
                    NSError* apiError = [NSError errorWithDomain:@"FlickrSearch" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Unknown API respons",NSLocalizedFailureReasonErrorKey, nil]];
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completion(nil,apiError);
                    }];
                }
                
                
                /** Process the dictionaries that contain photo information to create flickr photo data structures  **/
                
                NSMutableArray<FlickrPhoto*>* flickrPhotoArray = [[NSMutableArray alloc] init];
                
                for (NSDictionary*photoObjectDict in photosReceived) {
                    
                    NSString* photoID = [photoObjectDict valueForKey:@"id"];
                    NSInteger farm = [[photoObjectDict valueForKey:@"farm"] integerValue];
                    NSString* server = [photoObjectDict valueForKey:@"server"];
                    NSString* secret = [photoObjectDict valueForKey:@"secret"];
                    
                    if(!farm || !server || !secret || !photoID){
                        break;
                    } else {
                        FlickrPhoto* flickrPhoto = [[FlickrPhoto alloc] initWithPhotoID:photoID andWithFarm:farm andWithServer:server andWithSecret:secret];
                        
                        
                        NSURL* url = [flickrPhoto getFlickrImageURLWithSize:nil];
                        
                        
                        NSData* imageData = [NSData dataWithContentsOfURL:url];
                        
                        if(!url || !imageData){
                            break;
                        } else {
                            flickrPhoto.thumbnail = [UIImage imageWithData:imageData];
                            [flickrPhotoArray addObject:flickrPhoto];
                            
                            
                        }
                    }
                    
                    
                    
                }
                
                FlickrSearchResults* flickrSearchResults = [[FlickrSearchResults alloc] initWithSearchTerm:searchTerm andWithSearchResults:flickrPhotoArray];
                
                NSLog(@"The following FlickrSearchResults object was obtained via the callback method %@",[flickrSearchResults description]);
                
                
                completion(flickrSearchResults,nil);

                

                
            } @catch (NSException *exception) {
                
                completion(nil,nil);
                return;
                
            }
            
            
            
        }] resume];
    }
}

-(NSString *)flickrAPI{
    
    return @"ede81da6aec653f7189e27b9f02f9d63";
}

-(NSString *)flickrSecretCode{
    return @"18857fc39870009e";
}

-(NSURL*)getFlickrSearchURLForSearchTerm:(NSString*)searchTerm{
    
    NSString* escapedTerm = [searchTerm stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    
    NSString* urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=20&format=json&nojsoncallback=1",self.flickrAPI,escapedTerm, nil];
    
    return [NSURL URLWithString:urlString];
    
}

-(NSOperationQueue *)operationQueue{
    if(_operationQueue == nil){
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    
    return _operationQueue;
}

@end
