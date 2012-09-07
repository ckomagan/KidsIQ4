//
//  QuitController.h
//  KidsIQ4
//
//  Created by Chan Komagan on 8/26/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuitController : UIViewController {
    IBOutlet UIButton *dismissYes;
    IBOutlet UIButton *dismissNo;
}

-(IBAction)dismissView;
-(IBAction)loginScreen;

@end
