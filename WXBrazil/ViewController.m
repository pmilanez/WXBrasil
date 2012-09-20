//
//  ViewController.m
//  WXBrazil
//
//  Created by Pedro Milanez on 14/09/12.
//  Copyright (c) 2012 Pedro Milanez. All rights reserved.
//

#import "ViewController.h"
#import "LRResty.h"

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
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    //    NSString *dataAtual = [self getUTCDate:@"yyyyMMddHH"];
    
    //    NSDictionary *parameters = @{
    //    @"local" : _textFieldAeroporto.text,
    //    @"msg" : @"metar,taf,aviso_aerodromo,sigwx,sigmet,\
    //    airep,airmet,ciclone,cinzas,furacao,gamet,pilot,synop,\
    //    temp,tempestade,tornado,winten",
    //    @"data_ini" : dataAtual,
    //    @"data_fim" : dataAtual
    //    };
    //
    //        LRRestyResponse *response = [[LRResty client]
    //                                     get:@"http://www.redemet.aer.mil.br/aux/consulta_msg_aut.php"
    //                                     parameters:parameters];
    //
    //        NSMutableString *strResposta = [[NSMutableString alloc] initWithString:[response asString]];
    
    NSMutableString *strResposta = [[NSMutableString alloc] initWithString:@"\
                                    \
                                    \
                                    \
                                    2012012418 - METAR SBJD 241800Z 23006KT 9999 -RA SCT040 BKN080 25/21 Q1015 RETS=\
                                    2012012418 - TAF SBJD 241640Z 2418/2506 33005KT 8000 TSRA BKN025 FEW045CB TX29/2419Z TN19/2505ZBECMG 2420/2422 12005KT NSW FEW020 RMK PHH=\
                                    2012012418 - AVISO DE AERODROMO 1 VALIDO 251300/251700\
                                    PARA SBGR/SBSP/SBMT/SBBP/SBJD/SBKP OBSERVADO E\
                                    PREVISTO VENTO FORTE DE RAJADA 34018/28KT=\
                                    2012012418 - AVISO DE AERODROMO 1 VALIDO 262130/262400 PARA SBKP/SBJD\
                                    PREVISTO VENTO FORTE COM RAJADA 13015/25KT=\
                                    2012012418 - AVISO DE AERODROMO 1 VALIDO 270910/271100 PARA SBKP/SBJD/SBBP\
                                    PREVISTO VENTO FORTE COM RAJADA 13015/30KT=\
                                    2012012418 - AVISO DE AERODROMO 3 VALIDO 241620/241930 PARA\
                                    SBJD/SBKP/SBBP/SBYS/SBGP\
                                    PREVISTO TROVOADA COM VENTO DE RAJADA 34015/30KT=\
                                    2012012418 - AVISO DE AERODROMO 3 VALIDO 241620/241930 PARA\
                                    SBJD/SBKP/SBBP/SBYS/SBGP\
                                    PREVISTO TROVOADA COM VENTO DE RAJADA 34015/30KT=\
                                    2012012418 - AIREP de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - AIRMET de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - Ciclone de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - Cinzas Vulcânicas de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - Furacão de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - GAMET de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - PILOT de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - SIGWX de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - SIGMET de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - SYNOP de 'sbjd' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - TEMP de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - Tempestade de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    2012012418 - Tornado de 'SBJD' 24/01/2012 da(s) 18(UTC) não localizada na base de dados da REDEMET\
                                    "];
    
    // Regex EXP p/ retirar a data
    // (\d* - )
    [strResposta replaceOccurrencesOfString:@"(\\d* - )" withString:@"#"
                                    options:NSRegularExpressionSearch range:NSMakeRange(0, [strResposta length])];
    
    [strResposta replaceOccurrencesOfString:@"                                    " withString:@" "
                                    options:NSLiteralSearch range:NSMakeRange(0, [strResposta length])];
    
    // Retira toda linha vazia
    strResposta = (NSMutableString *)[strResposta stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Colocar todas as respostas separadas na array
    NSArray *arrayDados = [strResposta componentsSeparatedByString:@"#"];
    _dicResultadoFinal = [NSMutableDictionary new];
    
    for (NSMutableString *stringResultado in arrayDados) {
        // Pegando o nome da mensagem que vem na frente
        NSRange rangeNomeMsg = [stringResultado rangeOfString:@"\\w*" options:NSRegularExpressionSearch];
        
        if (rangeNomeMsg.location != NSNotFound) {
            // Pegando o nome da mensagem que vem na frente
            NSString *stringNomeMensagem = [stringResultado substringWithRange:rangeNomeMsg];
            
            if ([stringResultado length] > 0) {
                // Colocando no dicionário
                if (![_dicResultadoFinal objectForKey:stringNomeMensagem])
                {
                    [_dicResultadoFinal setObject:[stringResultado stringByTrimmingCharactersInSet:
                                                   [NSCharacterSet whitespaceCharacterSet]]
                                           forKey:[stringNomeMensagem uppercaseString]];
                }
                else {
                    NSMutableString *stringAntiga = [[NSMutableString alloc] initWithString:
                                                     [_dicResultadoFinal objectForKey:stringNomeMensagem]];
                    [stringAntiga appendString:@"##"];
                    [stringAntiga appendString:stringResultado];
                    [_dicResultadoFinal setObject:[stringAntiga stringByTrimmingCharactersInSet:
                                                   [NSCharacterSet whitespaceCharacterSet]]
                                           forKey:[stringNomeMensagem uppercaseString]];
                }
            }
        }
    }
    
    [_tableView reloadData];
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

#pragma mark - UITableView Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_dicResultadoFinal allKeys] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *tipoMsg = [[_dicResultadoFinal allKeys] objectAtIndex:section];
    NSInteger num = [[[_dicResultadoFinal objectForKey:tipoMsg] componentsSeparatedByString:@"##"] count];
    
    return num > 0 ? num : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableCellIdentifier = @"UITableViewCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentifier];
	}
    
    NSString *tipoMsg = [[_dicResultadoFinal allKeys] objectAtIndex:indexPath.section];
    NSArray *arrayMsgs = [[_dicResultadoFinal objectForKey:tipoMsg] componentsSeparatedByString:@"##"];
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
    NSArray *arrayMsgs = [[_dicResultadoFinal objectForKey:tipoMsg] componentsSeparatedByString:@"##"];
    if ([arrayMsgs count] == 0) {
        return 80.0;
    }
    else {
        return 160.0;
    }
}


@end
