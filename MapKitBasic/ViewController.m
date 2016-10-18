//  ViewController.m
//  MapKitBasic
//
//  Created by OnceAShadow on 5/1/16.
//  Copyright © 2016 OnceAShadow All rights reserved.


#import "ViewController.h"
#import <MapKit/MapKit.h>


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@implementation CatAnnotation

-(instancetype) initWithCoords:(CLLocationCoordinate2D)location{
    self = [super init];
    
    self.coordinate = location;
    
    return self;
}

@end

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) NSMutableArray* arrAnnotations;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // To setup Map:
    //      - Import MapKit
    //      - Add MKMapViewDelegate
    //      - Make sure mapView has a delegate
    //      - Add a Map to the view in story board
    //      - Add an IBOutlet of MKMapView
    
    // To setup CoreLocation:
    //      -Import CoreLocation
    //      -Add CLLoctionManagerDelegate
    //      -Declare a CLLocationManager
    //      -In Info.plist you need to add a line NSLocationWhenInUseUsageDescription and a message
    //      -Set the View as it's delegate
    //      -Choose desired GPS Accuracy
    //      -And/Or ActivityType
    //      -Then run method to request user's authorization to use the GPS

    // To setup Annotations:
    //      -Create an Object that conforms to the MKAnnotation protocol.
    //      -Make sure that object has a CLLocationCoordinate2D
    //      -Load an array of Annotations into an array
    //      -Add the Annotations to the MapView
    //      -Conform to viewForAnnotation with animatesDrop and canShowCallout
    
    self.locationManager = [CLLocationManager new];
        
    self.locationManager.delegate = self;
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestWhenInUseAuthorization];
        //[self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.activityType = CLActivityTypeFitness;
    [self.locationManager startUpdatingLocation];
    
    //self.mapView.showsUserLocation = YES;
    //self.mapView.showsPointsOfInterest = YES;
    
    [self createAnnotations];
}

-(void)createAnnotations{
    self.arrAnnotations = [NSMutableArray new];
    for(int i = 0; i < 100; ++i){
        double lat = (double)(90 - rand() % 180);
        double lon = (double)(180 - rand() % 360);

        CatAnnotation* tempLocation = [[CatAnnotation alloc] initWithCoords:CLLocationCoordinate2DMake(lat, lon)];
        tempLocation.title = @"I AM THE TITLE";
        tempLocation.subtitle = @"I AM THE SUBTITLE";
        [self.arrAnnotations addObject:tempLocation];
        
    }
    [self.mapView addAnnotations:self.arrAnnotations];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse ){
        [self.locationManager startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"%@", locations);
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    MKPinAnnotationView* annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"anno"];
    
    //annoView.userInteractionEnabled = true;
    annoView.canShowCallout = true;
    annoView.animatesDrop = true;
    
    return annoView;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
}

@end
