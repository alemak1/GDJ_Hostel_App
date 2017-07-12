//
//  ImageManagerB.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/26/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef ImageManagerB_h
#define ImageManagerB_h

@interface ImageManagerB : NSObject

typedef enum RoomCategory{
    ROOM_NO1 = 0,
    ROOM_NO2 = 1,
    ROOM_NO3,
    ROOM_NO4,
    ROOM_CATEGORY_END_INDEX
}RoomCategory;

+(ImageManagerB*)sharedManager;


/** Number of items in section is determined by number of strings in an array of image filepaths **/

-(NSInteger)getNumberOfItemsInSection:(NSInteger)section;


/** Accessor method for images **/

-(UIImage*)getImageForIndexPath:(NSIndexPath*)indexPath;


/** Helper method to validate the number of images loaded when using indexpath to access the image cache  **/

-(NSInteger)numberOfImagesLoadedForRoom1;

-(NSInteger)numberOfImagesLoadedForRoom2;

-(NSInteger)numberOfImagesLoadedForRoom3;

-(NSInteger)numberOfImagesLoadedForRoom4;


/** Helper methods to perform selective loading and unloading of image arrays **/

-(void) loadImageForRoomNo1;

-(void) loadImageForRoomNo2;

-(void) loadImageForRoomNo3;

-(void) loadImageForRoomNo4;

-(void)unloadImagesForRoomNo1;

-(void)unloadImagesForRoomNo2;

-(void)unloadImagesForRoomNo3;

-(void)unloadImagesForRoomNo4;


@end

#endif /* ImageManagerB_h */
