//
//  RedemetHelper.h
//  WXBrazil
//
//  Created by Pedro Milanez on 23/09/12.
//  Copyright (c) 2012 Pedro Milanez. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRedemetAPIAdress @"http://www.redemet.aer.mil.br/aux/consulta_msg_aut.php"
#define kRedemetMsgs @[@"metar", @"taf", @"aviso_aerodromo"];

typedef enum {
    RedemetTypeMetar,
    RedemetTypeTaf,
	RedemetTypeAvisoAerodromo,
} RedemetType;

typedef void (^RedemetResponseBlock)(NSArray *response);

@interface RedemetHelper : NSObject {
	NSArray *arrayMsgs;
}
@property (nonatomic, strong) NSArray *arrayMsgs;

+ (RedemetHelper *)sharedInstance;
-(void) getMessageFromRedemet:(NSString *)airport typeMsg:(RedemetType)redemetMsg withBlock:(RedemetResponseBlock)block;
@end
