//
//  SeoulFlickrSearchController.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef SeoulFlickrSearchController_h
#define SeoulFlickrSearchController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FlickrSearchResults.h"

@interface SeoulFlickSearchController : UICollectionViewController


@property NSMutableOrderedSet<FlickrSearchResults*>* searches;


@end

#endif /* SeoulFlickrSearchController_h */
