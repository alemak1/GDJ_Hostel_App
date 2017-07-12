//
//  AppDelegate.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/23/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;



@end

