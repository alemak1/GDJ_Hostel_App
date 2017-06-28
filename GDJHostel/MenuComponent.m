//
//  MenuComponent.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/24/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


#import "MenuComponent.h"

@interface MenuComponent ()

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) UITableView *optionsTableView;
@property (nonatomic, strong) NSArray *menuOptions;
@property (nonatomic, strong) NSArray *menuOptionImages;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic) MenuDirectionOptions menuDirection;
@property (nonatomic) CGRect menuFrame;
@property (nonatomic) CGRect menuInitialFrame;
@property (nonatomic) BOOL isMenuShown;

- (void)setupMenuView;
- (void)setupBackgroundView;
- (void)setupOptionsTableView;
- (void)setInitialTableViewSettings;
- (void)setupSwipeGestureRecognizer;

- (void)hideMenuWithGesture:(UISwipeGestureRecognizer *)gesture;

- (void)toggleMenu;

@property (nonatomic, strong) void(^selectionHandler)(NSInteger);


@end

@implementation MenuComponent

- (id)initMenuWithFrame:(CGRect)frame targetView:(UIView *)targetView direction:(MenuDirectionOptions)direction options:(NSArray *)options optionImages:(NSArray *)optionImages {
    if (self = [super init]) {
        self.menuFrame = frame;
        self.targetView = targetView;
        self.menuDirection = direction;
        self.menuOptions = options;
        self.menuOptionImages = optionImages;
        
        [self setupBackgroundView];
        
        // Setup the menu view.
        [self setupMenuView];
        
        // Setup the options table view.
        [self setupOptionsTableView];
        
        // Set the initial table view settings.
        [self setInitialTableViewSettings];
        
        // Setup the swipe gesture recognizer.
        [self setupSwipeGestureRecognizer];
        
        // Initialize the animator.
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.targetView];
        
        // Set the initial height for each cell row.
        self.optionCellHeight = 50.0;
        
        // Set the initial acceleration value (push magnitude).
        self.acceleration = 15.0;
        
        // Indicate that initially the menu is not shown.
        self.isMenuShown = NO;
        
    }
    
    return self;
}

-(void)setupMenuView{
    if (self.menuDirection == menuDirectionLeftToRight) {
        self.menuInitialFrame = CGRectMake(-self.menuFrame.size.width+20,
                                           self.menuFrame.origin.y,
                                           self.menuFrame.size.width,
                                           self.menuFrame.size.height);
    }
    else{
        self.menuInitialFrame = CGRectMake(self.targetView.frame.size.width-20,
                                           self.menuFrame.origin.y,
                                           self.menuFrame.size.width,
                                           self.menuFrame.size.height);
    }
    
    self.menuView = [[UIView alloc] initWithFrame:self.menuInitialFrame];
    [self.menuView setBackgroundColor:[UIColor colorWithRed:232.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [self.targetView addSubview:self.menuView];
}


-(void)setupBackgroundView{
    self.backgroundView = [[UIImageView alloc] initWithFrame:self.targetView.frame];
    self.backgroundView.image = [UIImage imageNamed:@"Lobby_1"];
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [self.backgroundView setAlpha:1.0];
    [self.targetView addSubview:self.backgroundView];
    
    CGFloat bgWidth = CGRectGetWidth(self.backgroundView.frame);
    CGFloat bgHeight = CGRectGetHeight(self.backgroundView.frame);
    
    CGRect labelFrame = CGRectMake(bgWidth*0.10, bgHeight*0.001, bgWidth*0.80, bgHeight*.40);
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:labelFrame];
    titleLabel.text = @"Please come in. Swipe from the right...";
    titleLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:30.0];
    titleLabel.textColor = [UIColor yellowColor];
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(10., 10.0);
    titleLabel.numberOfLines = 0;
    titleLabel.adjustsFontSizeToFitWidth = true;
    [self.backgroundView addSubview:titleLabel];
    
    /** Display the local time in Korea **/
    CGRect timeLabelFrame = CGRectMake(bgWidth*0.10, bgHeight*0.80, bgWidth*0.80, bgHeight*0.20);
    
    UILabel* timeLabel = [[UILabel alloc] initWithFrame:timeLabelFrame];
    
    NSDate* today = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"KST"]];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString* localDateString = [dateFormatter stringFromDate:today];
    
    [timeLabel setText:localDateString];
    [timeLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:30.0]];
    [timeLabel setNumberOfLines:1];
    [timeLabel setAdjustsFontSizeToFitWidth:YES];
    [timeLabel setMinimumScaleFactor:0.50];
    [self.backgroundView addSubview:timeLabel];
    
}

-(void)setupOptionsTableView{
    
    CGFloat menuFrameWidth = CGRectGetHeight(self.menuFrame);
    CGFloat menuFrameHeight = CGRectGetWidth(self.menuFrame);
    
    self.optionsTableView = [[UITableView alloc] initWithFrame:CGRectMake(menuFrameWidth*0.01, menuFrameHeight*0.55, self.menuFrame.size.width, self.menuFrame.size.height) style:UITableViewStylePlain];
    [self.optionsTableView setBackgroundColor:[UIColor clearColor]];
    [self.optionsTableView setScrollEnabled:NO];
    [self.optionsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.menuView addSubview:self.optionsTableView];
    
    CGRect logoFrame = CGRectMake(menuFrameWidth*0.10, menuFrameHeight*0.05, 120, 120);
    self.logoImageView = [[UIImageView alloc] initWithFrame:logoFrame];
    self.logoImageView.image = [UIImage imageNamed:@"smiley120"];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.menuView addSubview:self.logoImageView];
    
    [self.optionsTableView setDelegate:self];
    [self.optionsTableView setDataSource:self];
    
    
}

-(void)resetMenuView:(UITraitCollection*)newTraitCollection{
    
    [self.menuView removeFromSuperview];
    self.menuView = nil;
    
    if (self.menuDirection == menuDirectionLeftToRight) {
        self.menuInitialFrame = CGRectMake(-self.menuFrame.size.width+20,
                        self.menuFrame.origin.y,
                        self.menuFrame.size.width,
                        self.menuFrame.size.height);
    } else{
            self.menuInitialFrame = CGRectMake(self.targetView.frame.size.width-20,
                        self.menuFrame.origin.y,
                        self.menuFrame.size.width,
                        self.menuFrame.size.height);
        }
        
        self.menuView = [[UIView alloc] initWithFrame:self.menuInitialFrame];
        [self.menuView setBackgroundColor:[UIColor colorWithRed:232.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0]];
        [self.targetView addSubview:self.menuView];
    
    // Setup the options table view.
    [self resetOptionsTableView:[self.targetView traitCollection]];
    
    // Set the initial table view settings.
    [self setInitialTableViewSettings];
    
    // Setup the swipe gesture recognizer.
    [self setupSwipeGestureRecognizer];
    
    // Initialize the animator.
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.targetView];
    
    // Set the initial height for each cell row.
    self.optionCellHeight = 50.0;
    
    // Set the initial acceleration value (push magnitude).
    self.acceleration = 15.0;
    
    // Indicate that initially the menu is not shown.
    self.isMenuShown = NO;
    

}

-(void)resetOptionsTableView:(UITraitCollection*)newTraitCollection{
    
    NSLog(@"Resetting the options table view...");
    
    //Remove the options table view from the superview
    [self.optionsTableView removeFromSuperview];
    [self.logoImageView removeFromSuperview];
    
    self.optionsTableView = nil;
    self.logoImageView = nil;
    
    UIUserInterfaceSizeClass horizontalSC = [newTraitCollection horizontalSizeClass];
    UIUserInterfaceSizeClass verticalSC = [newTraitCollection verticalSizeClass];
    
    BOOL CW_CH = (horizontalSC == UIUserInterfaceSizeClassCompact && verticalSC == UIUserInterfaceSizeClassCompact);
    
    BOOL CW_RH = (horizontalSC == UIUserInterfaceSizeClassCompact && verticalSC == UIUserInterfaceSizeClassRegular);
    
    
    CGFloat menuFrameWidth = CGRectGetHeight(self.menuFrame);
    CGFloat menuFrameHeight = CGRectGetWidth(self.menuFrame);
    
    self.optionsTableView = [[UITableView alloc] initWithFrame:CGRectMake(menuFrameWidth*0.01, menuFrameHeight*0.44, self.menuFrame.size.width, self.menuFrame.size.height) style:UITableViewStylePlain];
    
    CGRect logoFrame = CGRectMake(menuFrameWidth*0.10, menuFrameHeight*0.02, 120, 120);

    if(CW_CH){
        self.optionsTableView = [[UITableView alloc] initWithFrame:CGRectMake(menuFrameWidth*0.01, menuFrameHeight*0.30, self.menuFrame.size.width, self.menuFrame.size.height*0.80) style:UITableViewStylePlain];
        
        logoFrame = CGRectMake(menuFrameWidth*0.10, menuFrameHeight*0.02, 80, 80);
        
    }
    
    if(CW_RH){
        //Not yet implemented
    }

    
    [self.optionsTableView setBackgroundColor:[UIColor clearColor]];
    [self.optionsTableView setScrollEnabled:NO];
    [self.optionsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.menuView addSubview:self.optionsTableView];
    
    
    self.logoImageView = [[UIImageView alloc] initWithFrame:logoFrame];
    self.logoImageView.image = [UIImage imageNamed:@"smiley120"];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.menuView addSubview:self.logoImageView];
    
    [self.optionsTableView setDelegate:self];
    [self.optionsTableView setDataSource:self];
    
    
}



- (void)setInitialTableViewSettings {
    self.tableSettings = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                          [UIFont fontWithName:@"Futura-CondensedMedium" size:30.0], @"font",
            [NSNumber numberWithInt:NSTextAlignmentLeft], @"textAlignment",
            [UIColor colorWithRed:245.0/255.0 green:231.0/255.0 blue:143.0/255.0 alpha:1.00], @"textColor",
            [NSNumber numberWithInt:UITableViewCellSelectionStyleGray], @"selectionStyle",
                          nil];
}


-(void)setupSwipeGestureRecognizer{
    UISwipeGestureRecognizer *hideMenuGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenuWithGesture:)];
    if (self.menuDirection == menuDirectionLeftToRight) {
        hideMenuGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    else{
        hideMenuGesture.direction = UISwipeGestureRecognizerDirectionRight;
    }
    [self.menuView addGestureRecognizer:hideMenuGesture];
}

- (void)toggleMenu{
    // Remove any previous behaviors added to the animator.
    [self.animator removeAllBehaviors];
    
    // The following variables will define the direction of the menu view animation.
    
    // This variable indicates the gravity direction.
    CGFloat gravityDirectionX;
    
    // These two points specify an invisible boundary where the menu view should collide.
    // The boundary must be always to the side of the gravity direction so as the menu view
    // can stop moving.
    CGPoint collisionPointFrom, collisionPointTo;
    
    // The higher the push magnitude value, the greater the acceleration of the menu view.
    // If that value is set to 0.0, then only the gravity force will be applied to the
    // menu view.
    CGFloat pushMagnitude = self.acceleration;
    
    // Check if the menu is shown or not.
    if (!self.isMenuShown) {
        // If the menu view is hidden and it's about to be shown, then specify each variable
        // value depending on the animation direction.
        if (self.menuDirection == menuDirectionLeftToRight) {
            // The value 1.0 means that gravity "moves" the view towards the right side.
            gravityDirectionX = 1.0;
            
            // The From and To points define an invisible boundary, where the X-origin point
            // equals to the desired X-origin point that the menu view should collide, and the
            // Y-origin points specify the highest and lowest point of the boundary.
            
            // If the menu view is being shown from left to right, then the collision boundary
            // should be defined so as to be at the right of the initial menu view position.
            collisionPointFrom = CGPointMake(self.menuFrame.size.width-20, self.menuFrame.origin.y);
            collisionPointTo = CGPointMake(self.menuFrame.size.width-20, self.menuFrame.size.height);
        }
        else{
            // The value -1.0 means that gravity "pulls" the view towards the left side.
            gravityDirectionX = -1.0;
            
            // If the menu view is being shown from right to left, then the collision boundary
            // should be defined so as to be at the left of the initial menu view position.
            collisionPointFrom = CGPointMake(self.targetView.frame.size.width - self.menuFrame.size.width+20, self.menuFrame.origin.y);
            collisionPointTo = CGPointMake(self.targetView.frame.size.width - self.menuFrame.size.width+20, self.menuFrame.size.height);
            
            // Set to the pushMagnitude variable the opposite value.
            pushMagnitude = (-1) * pushMagnitude;
        }
        
        // Make the background view semi-transparent.
        [self.backgroundView setAlpha:0.25];
    }
    else{
        // In case the menu is about to be hidden, then the exact opposite values should be
        // set to all variables for succeeding the opposite animation.
        
        if (self.menuDirection == menuDirectionLeftToRight) {
            gravityDirectionX = -1.0;
            collisionPointFrom = CGPointMake(-self.menuFrame.size.width+20, self.menuFrame.origin.y);
            collisionPointTo = CGPointMake(-self.menuFrame.size.width+20, self.menuFrame.size.height);
            
            // Set to the pushMagnitude variable the opposite value.
            pushMagnitude = (-1) * pushMagnitude;
        }
        else{
            gravityDirectionX = 1.0;
            collisionPointFrom = CGPointMake(self.targetView.frame.size.width + self.menuFrame.size.width-20, self.menuFrame.origin.y);
            collisionPointTo = CGPointMake(self.targetView.frame.size.width + self.menuFrame.size.width-20, self.menuFrame.size.height);
        }
        
        // Make the background view fully transparent.
        [self.backgroundView setAlpha:1.0];
    }
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.menuView]];
    [gravityBehavior setGravityDirection:CGVectorMake(gravityDirectionX, 0.0)];
    [self.animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.menuView]];
    [collisionBehavior addBoundaryWithIdentifier:@"collisionBoundary"
                                       fromPoint:collisionPointFrom
                                         toPoint:collisionPointTo];
    [self.animator addBehavior:collisionBehavior];
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.menuView]];
    [itemBehavior setElasticity:0.35];
    [self.animator addBehavior:itemBehavior];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.menuView] mode:UIPushBehaviorModeInstantaneous];
    [pushBehavior setMagnitude:pushMagnitude];
    [self.animator addBehavior:pushBehavior];
}

- (void)showMenuWithSelectionHandler:(void (^)(NSInteger))handler {
    if (!self.isMenuShown) {
        self.selectionHandler = handler;
        
        [self toggleMenu];
        
        self.isMenuShown = YES;
    }
}

- (void)hideMenuWithGesture:(UISwipeGestureRecognizer *)gesture {
    // Make a call to toggleMenu method for hiding the menu.
    [self toggleMenu];
    
    // Indicate that the menu is not shown.
    self.isMenuShown = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuOptions count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.optionCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"optionCell"];
    }
    
    // Set the selection style.
    [cell setSelectionStyle:[[self.tableSettings objectForKey:@"selectionStyle"] intValue]];
    
    // Set the cell's text and specify various properties of it.
    cell.textLabel.text = [self.menuOptions objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[self.tableSettings objectForKey:@"font"]];
    [cell.textLabel setTextAlignment:[[self.tableSettings objectForKey:@"textAlignment"] intValue]];
    [cell.textLabel setTextColor:[self.tableSettings objectForKey:@"textColor"]];
    
    // If the menu option images array is not nil, then set the cell image.
    if (self.menuOptionImages != nil) {
        [cell.imageView setImage:[UIImage imageNamed:[self.menuOptionImages objectAtIndex:indexPath.row]]];
        [cell.imageView setTintColor:[UIColor whiteColor]];
    }
    
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if (self.selectionHandler) {
        self.selectionHandler(indexPath.row);
    }
}
@end
