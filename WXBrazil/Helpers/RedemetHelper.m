//
//  RedemetHelper.m
//  WXBrazil
//
//  Created by Pedro Milanez on 23/09/12.
//  Copyright (c) 2012 Pedro Milanez. All rights reserved.
//

#import "RedemetHelper.h"
#import "LRResty.h"

@implementation RedemetHelper
@synthesize arrayMsgs = _arrayMsgs;

+ (RedemetHelper *)sharedInstance
{
    static dispatch_once_t once;
    static RedemetHelper *instance;
    dispatch_once(&once, ^ { instance = [[RedemetHelper alloc] init]; });
	
    return instance;
}


- (id)init
{
    self = [super init];
    if (self) {
        _arrayMsgs = kRedemetMsgs;
    }
    return self;
}


#pragma mark - Redemet Methods
-(void) getMessageFromRedemet:(NSString *)airport typeMsg:(RedemetType)redemetMsg withBlock:(RedemetResponseBlock)block {
	NSString *dataAtual = [self getUTCDate:@"yyyyMMddHH"];
    
    NSDictionary *parameters = @{
    @"local" : airport,
    @"msg" : [_arrayMsgs objectAtIndex:redemetMsg],
    @"data_ini" : dataAtual,
    @"data_fim" : dataAtual
    };
    
	[[LRResty client] get:kRedemetAPIAdress parameters:parameters withBlock:^(LRRestyResponse *response) {
		if (response.status != 200) {
			block(nil);
			return;
		}
		
		NSMutableArray *arrayResponse = [NSMutableArray new];
		NSMutableString *strResposta = [[NSMutableString alloc] initWithString:[response asString]];
		
		// Regex EXP p/ retirar a data
		// (\d* - )
		[strResposta replaceOccurrencesOfString:@"(\\d* - )" withString:@"#"
										options:NSRegularExpressionSearch range:NSMakeRange(0, [strResposta length])];
		
		// Retira toda linha vazia
		strResposta = (NSMutableString *)[strResposta stringByTrimmingCharactersInSet:
										  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		// Colocar todas as respostas separadas na array
		NSArray *arrayDados = [strResposta componentsSeparatedByString:@"#"];
		
		for (NSMutableString *stringResultado in arrayDados) {
			if (stringResultado.length > 0) {
				[arrayResponse addObject:[stringResultado stringByTrimmingCharactersInSet:
										  [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
			}
		}
		
		block(arrayResponse);
	}];
}

-(NSString *)getUTCDate:(NSString *) stringDateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:stringDateFormat];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}
@end

