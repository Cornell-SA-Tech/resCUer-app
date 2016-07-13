//
//  HomeViewController.m
//  ResCUer
//
//  Created by LiuYang on 5/3/16.
//  Copyright © 2016 LiuYang. All rights reserved.
//

#import "HomeViewController.h"
#import "SettingsViewController.h"
#import "MapViewController.h"

#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT (self.view.frame.size.height)

#define BUTTON_WIDTH (VIEW_WIDTH)
#define BUTTON_HEIGHT 90
#define BUTTON_CORNER_RADIUS 6
#define BUTTON_VDISTANCE 0
#define TOP_DISTANCE 100

#define SETTING_WIDTH 30
#define SETTING_HEIGHT 30

#define LEFT_ALIGNMENT (VIEW_WIDTH * 0.5 - BUTTON_WIDTH * 0.5)
//#define LEFT_ALIGNMENT 0
#define VERTICAL_DISTANCE 50

@interface HomeViewController ()
@property (nonatomic, strong) UIButton *RoCButton;
@property (nonatomic, strong) UIButton *policebutton;
@property (nonatomic, strong) UIButton *showWayButton;
@property (nonatomic, strong) UIButton *taxiButton;
@property (nonatomic, strong) UIButton *settingButton;

@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic) BOOL setted;

@end

@implementation HomeViewController

#pragma mark - Initializers
/*
- (instancetype)init {
    return nil;
}
 */

#pragma mark - View Settings
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"ResCuer";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"] isEqual: @1]) self.setted = NO;
    else self.setted = YES;
    [self viewSetup];
    [self setConstrains];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.barTintColor = NAVIGATION_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"firstLaunch"]);
    if (!self.setted) {
        SettingsViewController *svc = [[SettingsViewController alloc] init];
        svc.title = @"Settings";
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:svc];
        self.setted = YES;
        nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

- (void)viewSetup {
    // roc button
    self.RoCButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.RoCButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.RoCButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.RoCButton setImage:[UIImage imageNamed:@"friend"] forState:UIControlStateNormal];
    [self.RoCButton addTarget:self action:@selector(roc) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.RoCButton];
    
    // police button
    self.policebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.policebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.policebutton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.policebutton setImage:[UIImage imageNamed:@"police"] forState:UIControlStateNormal];
    [self.policebutton addTarget:self action:@selector(callPolice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.policebutton];
    
    // show way button
    self.showWayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showWayButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.showWayButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.showWayButton setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [self.showWayButton addTarget:self action:@selector(showWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showWayButton];
    
    self.taxiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.taxiButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.taxiButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.taxiButton setImage:[UIImage imageNamed:@"taxi"] forState:UIControlStateNormal];
    [self.taxiButton addTarget:self action:@selector(callTaxi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.taxiButton];
    
    // setting button
    self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settingButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.settingButton.backgroundColor = [UIColor clearColor];
    UIImage *settingIcon = [UIImage imageNamed:@"Dot"];
    [self.settingButton setImage:settingIcon forState:UIControlStateNormal];
    [self.settingButton addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.settingButton];
}

#pragma mark Constrants
- (void)setConstrains {
    // views dictionary
    NSDictionary *viewsDictionary = @{@"rocButton":self.RoCButton,
                                      @"policeButton":self.policebutton,
                                      @"showButton":self.showWayButton,
                                      @"settingButton":self.settingButton,
                                      @"taxiButton":self.taxiButton};
    // rocButton constraints
    NSDictionary *rocMetrics = @{@"rocWidth": @BUTTON_WIDTH,
                                 @"rocHeight": @BUTTON_HEIGHT,
                                 @"rocTopDistance":@TOP_DISTANCE};
    
    NSMutableArray *rocConstraints = [[NSMutableArray alloc] init];
    
    
    [rocConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rocButton(rocWidth)]"
                                                                     options:0
                                                                     metrics:rocMetrics
                                                                       views:viewsDictionary][0]];
    [rocConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rocButton(rocHeight)]"
                                                                      options:0
                                                                      metrics:rocMetrics
                                                                        views:viewsDictionary][0]];
    [rocConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-rocTopDistance-[rocButton]"
                                                                      options:0
                                                                      metrics:rocMetrics
                                                                        views:viewsDictionary][0]];
    [rocConstraints addObject:[NSLayoutConstraint constraintWithItem:self.RoCButton
                                                           attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeCenterX
                                                          multiplier:1.0f
                                                            constant:0.0f]];
    [NSLayoutConstraint activateConstraints:(NSArray *)rocConstraints];
    
    // police button
    NSDictionary *policeMetrics = @{@"policeWidth":@BUTTON_WIDTH,
                                    @"policeHeight":@BUTTON_HEIGHT,
                                    @"policeVdis":@BUTTON_VDISTANCE};
    
    NSMutableArray *policeConstraints = [[NSMutableArray alloc] init];
    [policeConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[policeButton(policeWidth)]"
                                                                         options:0
                                                                         metrics:policeMetrics
                                                                           views:viewsDictionary][0]];
    [policeConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[policeButton(policeHeight)]"
                                                                         options:0
                                                                         metrics:policeMetrics
                                                                           views:viewsDictionary][0]];
    [policeConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rocButton]-(policeVdis)-[policeButton]"
                                                                        options:0
                                                                        metrics:policeMetrics
                                                                           views:viewsDictionary][0]];
    [policeConstraints addObject:[NSLayoutConstraint constraintWithItem:self.policebutton
                                                           attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeCenterX
                                                          multiplier:1.0f
                                                            constant:0.0f]];
    [NSLayoutConstraint activateConstraints:(NSArray *)policeConstraints];
    
    // show me way home
    NSDictionary *showMetrics = @{@"showWidth":@BUTTON_WIDTH,
                                  @"showHeight":@BUTTON_HEIGHT,
                                  @"showVdis":@BUTTON_VDISTANCE};
    
    NSMutableArray *showConstraints = [[NSMutableArray alloc] init];
    [showConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[showButton(showWidth)]"
                                                                       options:0
                                                                       metrics:showMetrics
                                                                         views:viewsDictionary][0]];
    [showConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[showButton(showHeight)]"
                                                                       options:0
                                                                       metrics:showMetrics
                                                                         views:viewsDictionary][0]];
    [showConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[policeButton]-(showVdis)-[showButton]"
                                                                      options:0
                                                                      metrics:showMetrics
                                                                         views:viewsDictionary][0]];
    [showConstraints addObject:[NSLayoutConstraint constraintWithItem:self.showWayButton
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.view
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0f
                                                             constant:0.0f]];
    [NSLayoutConstraint activateConstraints:(NSArray *)showConstraints];
    
    // call taxi
    NSDictionary *taxiMetrics = @{@"taxiVDis":@BUTTON_VDISTANCE,
                                 @"taxiWidt":@BUTTON_WIDTH,
                                 @"taxiHeight":@BUTTON_HEIGHT};
    NSMutableArray *taxiConstraints = [[NSMutableArray alloc] init];
    [taxiConstraints addObject:[NSLayoutConstraint constraintWithItem:self.taxiButton
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.policebutton
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1.0f
                                                             constant:0.0f]];
    [taxiConstraints addObject:[NSLayoutConstraint constraintWithItem:self.taxiButton
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.policebutton
                                                            attribute:NSLayoutAttributeHeight
                                                           multiplier:1.0f
                                                             constant:0.0f]];
    [taxiConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[showButton]-(taxiVDis)-[taxiButton]"
                                                                       options:0
                                                                       metrics:taxiMetrics
                                                                         views:viewsDictionary][0]];
    [taxiConstraints addObject:[NSLayoutConstraint constraintWithItem:self.taxiButton
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.view
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0f
                                                             constant:0.0f]];
    [NSLayoutConstraint activateConstraints:taxiConstraints];
    
    // setting button
    NSDictionary *settingMetrics = @{@"settingWidth":@SETTING_WIDTH,
                                     @"settingHeight":@SETTING_HEIGHT};
    
    NSMutableArray *settingConstraints = [[NSMutableArray alloc] init];
    [settingConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[settingButton(settingWidth)]"
                                                                          options:0
                                                                          metrics:settingMetrics
                                                                            views:viewsDictionary][0]];
    [settingConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[settingButton(settingHeight)]"
                                                                          options:0
                                                                          metrics:settingMetrics
                                                                            views:viewsDictionary][0]];
    [settingConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[settingButton]-(settingWidth)-|"
                                                                         options:0
                                                                         metrics:settingMetrics
                                                                            views:viewsDictionary][0]];
    [settingConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[settingButton]-(settingHeight)-|"
                                                                          options:0
                                                                          metrics:settingMetrics
                                                                            views:viewsDictionary][0]];
    [NSLayoutConstraint activateConstraints:settingConstraints];
    
}


#pragma mark - Actions
- (void)roc {
#ifdef DEBUG
    NSLog(@"RA on call!");
#endif
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:PHONE_NUMBER];
    NSString *phoneString = [NSString stringWithFormat:@"tel://%@", phoneNumber];
    NSURL *phoneURL = [[NSURL alloc] initWithString:phoneString];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

- (void)callPolice {
#ifdef DEBUG
    NSLog(@"Call the police");
#endif
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Call the police?" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
#ifdef DEBUG
        NSLog(@"caaaal");
#endif
        NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"policeNumber"];
        NSString *phoneString = [NSString stringWithFormat:@"tel://%@", phoneNumber];
        NSURL *phoneURL = [[NSURL alloc] initWithString:phoneString];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:defaultAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showWay {
    /*
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//    MKMapItem *toLocation = [
    float currentLatitude = currentLocation.placemark.location.coordinate.latitude;
    float currentLongitude = currentLocation.placemark.location.coordinate.longitude;
    
    CLLocationCoordinate2D coord1 = CLLocationCoordinate2DMake(currentLatitude,currentLongitude);
    CLLocationCoordinate2D coord2 = CLLocationCoordinate2DMake(29, 129);
    
    MKMapItem *initLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coord1 addressDictionary:nil]];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coord2 addressDictionary:nil]];
//    initLocation.name = @"上海";
//    toLocation.name = @"宁波";
    NSArray *items = @[initLocation, toLocation];
    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking,
                              MKLaunchOptionsMapTypeKey:[NSNumber numberWithInteger:MKMapTypeStandard],
                              MKLaunchOptionsShowsTrafficKey:@NO};
    [MKMapItem openMapsWithItems:items launchOptions:options];
    
//    CLGeocoder *coder = [[CLGeocoder alloc] init];
//    [coder geocodeAddressString:@"宁波" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        MKPlacemark *startPlace = [[MKPlacemark alloc] initWithPlacemark:[placemarks firstObject]];
//        
//        
//    }]; */
    MapViewController *mvc = [[MapViewController alloc] init];
    [self presentViewController:mvc animated:YES completion:nil];
}

- (void)callTaxi {
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"taxiNumber"];
    NSString *phoneString = [NSString stringWithFormat:@"tel://%@", phoneNumber];
    NSLog(@"%@", phoneString);
    NSURL *phoneURL = [[NSURL alloc] initWithString:phoneString];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

- (void)settings {
    SettingsViewController *svc = [[SettingsViewController alloc] init];
//    svc.title = @"Settings";
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:svc];
    nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nvc animated:YES completion:nil];
}

#pragma mark - Help Functions


#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
