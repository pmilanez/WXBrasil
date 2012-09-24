//
//  ViewController.m
//  WXBrazil
//
//  Created by Pedro Milanez on 14/09/12.
//  Copyright (c) 2012 Pedro Milanez. All rights reserved.
//

#import "ViewController.h"
#import "RedemetHelper.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize _tableView;
@synthesize _dicResultadoFinal;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _dicResultadoFinal = [NSMutableDictionary new];
    
}

- (void)viewDidUnload
{
    [self set_tableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)procurarDados:(id)sender {
	_dicResultadoFinal = [NSMutableDictionary new];
	
	RedemetHelper *redemetHelper = [RedemetHelper sharedInstance];
	[redemetHelper getMessageFromRedemet:@"SBKP" typeMsg:RedemetTypeMetar withBlock:^(NSArray *response) {
		if (response) {
			[_dicResultadoFinal setObject:response forKey:@"METAR"];
			[_tableView reloadData];
		}
	}];
	
	[redemetHelper getMessageFromRedemet:@"SBKP" typeMsg:RedemetTypeTaf withBlock:^(NSArray *response) {
		if (response) {
			[_dicResultadoFinal setObject:response forKey:@"TAF"];
			[_tableView reloadData];
		}
	}];
	
	[redemetHelper getMessageFromRedemet:@"SBKP" typeMsg:RedemetTypeAvisoAerodromo withBlock:^(NSArray *response) {
		if (response) {
			[_dicResultadoFinal setObject:response forKey:@"AVISO AERÓDROMO"];
			[_tableView reloadData];
		}
	}];
}

#pragma mark - UITableView Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_dicResultadoFinal allKeys] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *tipoMsg = [[_dicResultadoFinal allKeys] objectAtIndex:section];
    NSInteger num = [[_dicResultadoFinal objectForKey:tipoMsg] count];
    
    return num > 0 ? num : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableCellIdentifier = @"UITableViewCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentifier];
	}
    
    NSString *tipoMsg = [[_dicResultadoFinal allKeys] objectAtIndex:indexPath.section];
    NSArray *arrayMsgs = [_dicResultadoFinal objectForKey:tipoMsg];
    if ([arrayMsgs count] == 0) {
        cell.textLabel.text = [_dicResultadoFinal objectForKey:tipoMsg];
    }
    else {
        cell.textLabel.text =  [arrayMsgs objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.numberOfLines = 99;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[_dicResultadoFinal allKeys] objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tipoMsg = [[_dicResultadoFinal allKeys] objectAtIndex:indexPath.section];
    NSArray *arrayMsgs = [_dicResultadoFinal objectForKey:tipoMsg];
    if ([arrayMsgs count] == 0) {
        return 80.0;
    }
    else {
        return 160.0;
    }
}


@end
