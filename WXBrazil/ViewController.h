//
//  ViewController.h
//  WXBrazil
//
//  Created by Pedro Milanez on 14/09/12.
//  Copyright (c) 2012 Pedro Milanez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableDictionary *_dicResultadoFinal;
}
@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (nonatomic, retain) NSMutableDictionary *_dicResultadoFinal;
- (IBAction)procurarDados:(id)sender;

@end
