//  ViewController.h
//  MapKitBasic
//
//  Created by OnceAShadow on 5/1/16.
//  Copyright © 2016 OnceAShadow All rights reserved.


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CatAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy,nonatomic) NSString* title;
@property (copy,nonatomic) NSString* subtitle;

-(instancetype) initWithCoords:(CLLocationCoordinate2D)location;

@end

@interface ViewController : UIViewController


@end

