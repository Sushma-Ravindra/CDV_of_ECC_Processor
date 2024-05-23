
module red(D,r);

input wire [325:0] D;
output wire [162:0] r;

wire [162:0] M;
wire [162:0] W;

assign M[0] = D[0] ^ D[163] ^ D[319];
assign M[1] = D[1] ^ D[164] ^ D[320];
assign M[2] = D[2] ^ D[165] ^ D[321];
assign M[3] = D[3] ^ D[166] ^ D[322];
assign M[4] = D[4] ^ D[167] ^ D[323];
assign M[5] = D[5] ^ D[168] ^ D[324];

assign W[6] = D[6] ^ D[157 + 6] ^ D[160 + 6];
assign W[7] = D[7] ^ D[157 + 7] ^ D[160 + 7];
assign W[8] = D[8] ^ D[157 + 8] ^ D[160 + 8];
assign W[9] = D[9] ^ D[157 + 9] ^ D[160 + 9];
assign W[10] = D[10] ^ D[157 + 10] ^ D[160 + 10];
assign W[11] = D[11] ^ D[157 + 11] ^ D[160 + 11];
assign W[12] = D[12] ^ D[157 + 12] ^ D[160 + 12];
assign W[13] = D[13] ^ D[157 + 13] ^ D[160 + 13];
assign W[14] = D[14] ^ D[157 + 14] ^ D[160 + 14];
assign W[15] = D[15] ^ D[157 + 15] ^ D[160 + 15];
assign W[16] = D[16] ^ D[157 + 16] ^ D[160 + 16];
assign W[17] = D[17] ^ D[157 + 17] ^ D[160 + 17];
assign W[18] = D[18] ^ D[157 + 18] ^ D[160 + 18];
assign W[19] = D[19] ^ D[157 + 19] ^ D[160 + 19];
assign W[20] = D[20] ^ D[157 + 20] ^ D[160 + 20];
assign W[21] = D[21] ^ D[157 + 21] ^ D[160 + 21];
assign W[22] = D[22] ^ D[157 + 22] ^ D[160 + 22];
assign W[23] = D[23] ^ D[157 + 23] ^ D[160 + 23];
assign W[24] = D[24] ^ D[157 + 24] ^ D[160 + 24];
assign W[25] = D[25] ^ D[157 + 25] ^ D[160 + 25];
assign W[26] = D[26] ^ D[157 + 26] ^ D[160 + 26];
assign W[27] = D[27] ^ D[157 + 27] ^ D[160 + 27];
assign W[28] = D[28] ^ D[157 + 28] ^ D[160 + 28];
assign W[29] = D[29] ^ D[157 + 29] ^ D[160 + 29];
assign W[30] = D[30] ^ D[157 + 30] ^ D[160 + 30];
assign W[31] = D[31] ^ D[157 + 31] ^ D[160 + 31];
assign W[32] = D[32] ^ D[157 + 32] ^ D[160 + 32];
assign W[33] = D[33] ^ D[157 + 33] ^ D[160 + 33];
assign W[34] = D[34] ^ D[157 + 34] ^ D[160 + 34];
assign W[35] = D[35] ^ D[157 + 35] ^ D[160 + 35];
assign W[36] = D[36] ^ D[157 + 36] ^ D[160 + 36];
assign W[37] = D[37] ^ D[157 + 37] ^ D[160 + 37];
assign W[38] = D[38] ^ D[157 + 38] ^ D[160 + 38];
assign W[39] = D[39] ^ D[157 + 39] ^ D[160 + 39];
assign W[40] = D[40] ^ D[157 + 40] ^ D[160 + 40];
assign W[41] = D[41] ^ D[157 + 41] ^ D[160 + 41];
assign W[42] = D[42] ^ D[157 + 42] ^ D[160 + 42];
assign W[43] = D[43] ^ D[157 + 43] ^ D[160 + 43];
assign W[44] = D[44] ^ D[157 + 44] ^ D[160 + 44];
assign W[45] = D[45] ^ D[157 + 45] ^ D[160 + 45];
assign W[46] = D[46] ^ D[157 + 46] ^ D[160 + 46];
assign W[47] = D[47] ^ D[157 + 47] ^ D[160 + 47];
assign W[48] = D[48] ^ D[157 + 48] ^ D[160 + 48];
assign W[49] = D[49] ^ D[157 + 49] ^ D[160 + 49];
assign W[50] = D[50] ^ D[157 + 50] ^ D[160 + 50];
assign W[51] = D[51] ^ D[157 + 51] ^ D[160 + 51];
assign W[52] = D[52] ^ D[157 + 52] ^ D[160 + 52];
assign W[53] = D[53] ^ D[157 + 53] ^ D[160 + 53];
assign W[54] = D[54] ^ D[157 + 54] ^ D[160 + 54];
assign W[55] = D[55] ^ D[157 + 55] ^ D[160 + 55];
assign W[56] = D[56] ^ D[157 + 56] ^ D[160 + 56];
assign W[57] = D[57] ^ D[157 + 57] ^ D[160 + 57];
assign W[58] = D[58] ^ D[157 + 58] ^ D[160 + 58];
assign W[59] = D[59] ^ D[157 + 59] ^ D[160 + 59];
assign W[60] = D[60] ^ D[157 + 60] ^ D[160 + 60];
assign W[61] = D[61] ^ D[157 + 61] ^ D[160 + 61];
assign W[62] = D[62] ^ D[157 + 62] ^ D[160 + 62];
assign W[63] = D[63] ^ D[157 + 63] ^ D[160 + 63];
assign W[64] = D[64] ^ D[157 + 64] ^ D[160 + 64];
assign W[65] = D[65] ^ D[157 + 65] ^ D[160 + 65];
assign W[66] = D[66] ^ D[157 + 66] ^ D[160 + 66];
assign W[67] = D[67] ^ D[157 + 67] ^ D[160 + 67];
assign W[68] = D[68] ^ D[157 + 68] ^ D[160 + 68];
assign W[69] = D[69] ^ D[157 + 69] ^ D[160 + 69];
assign W[70] = D[70] ^ D[157 + 70] ^ D[160 + 70];
assign W[71] = D[71] ^ D[157 + 71] ^ D[160 + 71];
assign W[72] = D[72] ^ D[157 + 72] ^ D[160 + 72];
assign W[73] = D[73] ^ D[157 + 73] ^ D[160 + 73];
assign W[74] = D[74] ^ D[157 + 74] ^ D[160 + 74];
assign W[75] = D[75] ^ D[157 + 75] ^ D[160 + 75];
assign W[76] = D[76] ^ D[157 + 76] ^ D[160 + 76];
assign W[77] = D[77] ^ D[157 + 77] ^ D[160 + 77];
assign W[78] = D[78] ^ D[157 + 78] ^ D[160 + 78];
assign W[79] = D[79] ^ D[157 + 79] ^ D[160 + 79];
assign W[80] = D[80] ^ D[157 + 80] ^ D[160 + 80];
assign W[81] = D[81] ^ D[157 + 81] ^ D[160 + 81];
assign W[82] = D[82] ^ D[157 + 82] ^ D[160 + 82];
assign W[83] = D[83] ^ D[157 + 83] ^ D[160 + 83];
assign W[84] = D[84] ^ D[157 + 84] ^ D[160 + 84];
assign W[85] = D[85] ^ D[157 + 85] ^ D[160 + 85];
assign W[86] = D[86] ^ D[157 + 86] ^ D[160 + 86];
assign W[87] = D[87] ^ D[157 + 87] ^ D[160 + 87];
assign W[88] = D[88] ^ D[157 + 88] ^ D[160 + 88];
assign W[89] = D[89] ^ D[157 + 89] ^ D[160 + 89];
assign W[90] = D[90] ^ D[157 + 90] ^ D[160 + 90];
assign W[91] = D[91] ^ D[157 + 91] ^ D[160 + 91];
assign W[92] = D[92] ^ D[157 + 92] ^ D[160 + 92];
assign W[93] = D[93] ^ D[157 + 93] ^ D[160 + 93];
assign W[94] = D[94] ^ D[157 + 94] ^ D[160 + 94];
assign W[95] = D[95] ^ D[157 + 95] ^ D[160 + 95];
assign W[96] = D[96] ^ D[157 + 96] ^ D[160 + 96];
assign W[97] = D[97] ^ D[157 + 97] ^ D[160 + 97];
assign W[98] = D[98] ^ D[157 + 98] ^ D[160 + 98];   
assign W[99] = D[99] ^ D[157 + 99] ^ D[160 + 99];
assign W[100] = D[100] ^ D[157 + 100] ^ D[160 + 100];
assign W[101] = D[101] ^ D[157 + 101] ^ D[160 + 101];
assign W[102] = D[102] ^ D[157 + 102] ^ D[160 + 102];
assign W[103] = D[103] ^ D[157 + 103] ^ D[160 + 103];
assign W[104] = D[104] ^ D[157 + 104] ^ D[160 + 104];
assign W[105] = D[105] ^ D[157 + 105] ^ D[160 + 105];
assign W[106] = D[106] ^ D[157 + 106] ^ D[160 + 106];
assign W[107] = D[107] ^ D[157 + 107] ^ D[160 + 107];
assign W[108] = D[108] ^ D[157 + 108] ^ D[160 + 108];
assign W[109] = D[109] ^ D[157 + 109] ^ D[160 + 109];
assign W[110] = D[110] ^ D[157 + 110] ^ D[160 + 110];
assign W[111] = D[111] ^ D[157 + 111] ^ D[160 + 111];
assign W[112] = D[112] ^ D[157 + 112] ^ D[160 + 112];
assign W[113] = D[113] ^ D[157 + 113] ^ D[160 + 113];
assign W[114] = D[114] ^ D[157 + 114] ^ D[160 + 114];
assign W[115] = D[115] ^ D[157 + 115] ^ D[160 + 115];
assign W[116] = D[116] ^ D[157 + 116] ^ D[160 + 116];
assign W[117] = D[117] ^ D[157 + 117] ^ D[160 + 117];
assign W[118] = D[118] ^ D[157 + 118] ^ D[160 + 118];
assign W[119] = D[119] ^ D[157 + 119] ^ D[160 + 119];
assign W[120] = D[120] ^ D[157 + 120] ^ D[160 + 120];
assign W[121] = D[121] ^ D[157 + 121] ^ D[160 + 121];
assign W[122] = D[122] ^ D[157 + 122] ^ D[160 + 122];
assign W[123] = D[123] ^ D[157 + 123] ^ D[160 + 123];
assign W[124] = D[124] ^ D[157 + 124] ^ D[160 + 124];
assign W[125] = D[125] ^ D[157 + 125] ^ D[160 + 125];
assign W[126] = D[126] ^ D[157 + 126] ^ D[160 + 126];
assign W[127] = D[127] ^ D[157 + 127] ^ D[160 + 127];
assign W[128] = D[128] ^ D[157 + 128] ^ D[160 + 128];
assign W[129] = D[129] ^ D[157 + 129] ^ D[160 + 129];
assign W[130] = D[130] ^ D[157 + 130] ^ D[160 + 130];
assign W[131] = D[131] ^ D[157 + 131] ^ D[160 + 131];
assign W[132] = D[132] ^ D[157 + 132] ^ D[160 + 132];
assign W[133] = D[133] ^ D[157 + 133] ^ D[160 + 133];
assign W[134] = D[134] ^ D[157 + 134] ^ D[160 + 134];
assign W[135] = D[135] ^ D[157 + 135] ^ D[160 + 135];
assign W[136] = D[136] ^ D[157 + 136] ^ D[160 + 136];
assign W[137] = D[137] ^ D[157 + 137] ^ D[160 + 137];
assign W[138] = D[138] ^ D[157 + 138] ^ D[160 + 138];
assign W[139] = D[139] ^ D[157 + 139] ^ D[160 + 139];
assign W[140] = D[140] ^ D[157 + 140] ^ D[160 + 140];
assign W[141] = D[141] ^ D[157 + 141] ^ D[160 + 141];
assign W[142] = D[142] ^ D[157 + 142] ^ D[160 + 142];
assign W[143] = D[143] ^ D[157 + 143] ^ D[160 + 143];
assign W[144] = D[144] ^ D[157 + 144] ^ D[160 + 144];
assign W[145] = D[145] ^ D[157 + 145] ^ D[160 + 145];
assign W[146] = D[146] ^ D[157 + 146] ^ D[160 + 146];
assign W[147] = D[147] ^ D[157 + 147] ^ D[160 + 147];
assign W[148] = D[148] ^ D[157 + 148] ^ D[160 + 148];
assign W[149] = D[149] ^ D[157 + 149] ^ D[160 + 149];
assign W[150] = D[150] ^ D[157 + 150] ^ D[160 + 150];
assign W[151] = D[151] ^ D[157 + 151] ^ D[160 + 151];
assign W[152] = D[152] ^ D[157 + 152] ^ D[160 + 152];
assign W[153] = D[153] ^ D[157 + 153] ^ D[160 + 153];
assign W[154] = D[154] ^ D[157 + 154] ^ D[160 + 154];
assign W[155] = D[155] ^ D[157 + 155] ^ D[160 + 155];
assign W[156] = D[156] ^ D[157 + 156] ^ D[160 + 156];
assign W[157] = D[157] ^ D[157 + 157] ^ D[160 + 157];
assign W[158] = D[158] ^ D[157 + 158] ^ D[160 + 158];
assign W[159] = D[159] ^ D[157 + 159] ^ D[160 + 159];
assign W[160] = D[160] ^ D[157 + 160] ^ D[160 + 160];
assign W[161] = D[161] ^ D[157 + 161] ^ D[160 + 161];
assign W[162] = D[162] ^ D[157 + 162] ^ D[160 + 162];
 

// Logic for computing r based on the specified conditions
assign r[0] = M[0] ^ D[320]^D[323];
assign r[1] = M[1] ^ D[321]^D[324];
assign r[2] = M[2] ^ D[322];  
assign r[3] = M[3] ^ D[163]^D[319]^D[320];
assign r[4] = M[4] ^ D[164]^D[320]^D[321];
assign r[5] = M[5] ^ D[165]^D[321]^D[322]; 

//for i = 6
assign r[6] = W[6] ^ D[163+6]^D[313+6]^D[313+6]^D[316+6];  


// Example for i = 7 to 10
assign r[7] = W[7] ^ D[7+156]^D[7+163]^D[7+312]^D[7+314];
assign r[8] = W[8] ^ D[8+156]^D[8+163]^D[8+312]^D[8+314];
assign r[9] = W[9] ^ D[9+156]^D[9+163]^D[9+312]^D[9+314];
assign r[10] = W[10] ^ D[10+156]^D[10+163]^D[10+312]^D[10+314];

// Example for i = 11 to 12
assign r[11] = W[11] ^ D[11+156]^D[11+163]^D[11+312];
assign r[12] = W[12] ^ D[12+156]^D[12+163]^D[12+312];

// Example for i = 13 to 161
assign r[13] = W[13] ^ D[169] ^ D[176];
assign r[14] = W[14] ^ D[170] ^ D[177];
assign r[15] = W[15] ^ D[171] ^ D[178];
assign r[16] = W[16] ^ D[172] ^ D[179];
assign r[17] = W[17] ^ D[173] ^ D[180];
assign r[18] = W[18] ^ D[174] ^ D[181];
assign r[19] = W[19] ^ D[175] ^ D[182];
assign r[20] = W[20] ^ D[176] ^ D[183];
assign r[21] = W[21] ^ D[177] ^ D[184];
assign r[22] = W[22] ^ D[178] ^ D[185];
assign r[23] = W[23] ^ D[179] ^ D[186];
assign r[24] = W[24] ^ D[180] ^ D[187];
assign r[25] = W[25] ^ D[181] ^ D[188];
assign r[26] = W[26] ^ D[182] ^ D[189];
assign r[27] = W[27] ^ D[183] ^ D[190];
assign r[28] = W[28] ^ D[184] ^ D[191];
assign r[29] = W[29] ^ D[185] ^ D[192];
assign r[30] = W[30] ^ D[186] ^ D[193];
assign r[31] = W[31] ^ D[187] ^ D[194];
assign r[32] = W[32] ^ D[188] ^ D[195];
assign r[33] = W[33] ^ D[189] ^ D[196];
assign r[34] = W[34] ^ D[190] ^ D[197];
assign r[35] = W[35] ^ D[191] ^ D[198];
assign r[36] = W[36] ^ D[192] ^ D[199];
assign r[37] = W[37] ^ D[193] ^ D[200];
assign r[38] = W[38] ^ D[194] ^ D[201];
assign r[39] = W[39] ^ D[195] ^ D[202];
assign r[40] = W[40] ^ D[196] ^ D[203];
assign r[41] = W[41] ^ D[197] ^ D[204];
assign r[42] = W[42] ^ D[198] ^ D[205];
assign r[43] = W[43] ^ D[199] ^ D[206];
assign r[44] = W[44] ^ D[200] ^ D[207];
assign r[45] = W[45] ^ D[201] ^ D[208];
assign r[46] = W[46] ^ D[202] ^ D[209];
assign r[47] = W[47] ^ D[203] ^ D[210];
assign r[48] = W[48] ^ D[204] ^ D[211];
assign r[49] = W[49] ^ D[205] ^ D[212];
assign r[50] = W[50] ^ D[206] ^ D[213];
assign r[51] = W[51] ^ D[207] ^ D[214];
assign r[52] = W[52] ^ D[208] ^ D[215];
assign r[53] = W[53] ^ D[209] ^ D[216];
assign r[54] = W[54] ^ D[210] ^ D[217];
assign r[55] = W[55] ^ D[211] ^ D[218];
assign r[56] = W[56] ^ D[212] ^ D[219];
assign r[57] = W[57] ^ D[213] ^ D[220];
assign r[58] = W[58] ^ D[214] ^ D[221];
assign r[59] = W[59] ^ D[215] ^ D[222];
assign r[60] = W[60] ^ D[216] ^ D[223];
assign r[61] = W[61] ^ D[217] ^ D[224];
assign r[62] = W[62] ^ D[218] ^ D[225];
assign r[63] = W[63] ^ D[219] ^ D[226];
assign r[64] = W[64] ^ D[220] ^ D[227];
assign r[65] = W[65] ^ D[221] ^ D[228];
assign r[66] = W[66] ^ D[222] ^ D[229];
assign r[67] = W[67] ^ D[223] ^ D[230];
assign r[68] = W[68] ^ D[224] ^ D[231];
assign r[69] = W[69] ^ D[225] ^ D[232];
assign r[70] = W[70] ^ D[226] ^ D[233];
assign r[71] = W[71] ^ D[227] ^ D[234];
assign r[72] = W[72] ^ D[228] ^ D[235];
assign r[73] = W[73] ^ D[229] ^ D[236];
assign r[74] = W[74] ^ D[230] ^ D[237];
assign r[75] = W[75] ^ D[231] ^ D[238];
assign r[76] = W[76] ^ D[232] ^ D[239];
assign r[77] = W[77] ^ D[233] ^ D[240];
assign r[78] = W[78] ^ D[234] ^ D[241];
assign r[79] = W[79] ^ D[235] ^ D[242];
assign r[80] = W[80] ^ D[236] ^ D[243];
assign r[81] = W[81] ^ D[237] ^ D[244];
assign r[82] = W[82] ^ D[238] ^ D[245];
assign r[83] = W[83] ^ D[239] ^ D[246];
assign r[84] = W[84] ^ D[240] ^ D[247];
assign r[85] = W[85] ^ D[241] ^ D[248];
assign r[86] = W[86] ^ D[242] ^ D[249];
assign r[87] = W[87] ^ D[243] ^ D[250];
assign r[88] = W[88] ^ D[244] ^ D[251];
assign r[89] = W[89] ^ D[245] ^ D[252];
assign r[90] = W[90] ^ D[246] ^ D[253];
assign r[91] = W[91] ^ D[247] ^ D[254];
assign r[92] = W[92] ^ D[248] ^ D[255];
assign r[93] = W[93] ^ D[249] ^ D[256];
assign r[94] = W[94] ^ D[250] ^ D[257];
assign r[95] = W[95] ^ D[251] ^ D[258];
assign r[96] = W[96] ^ D[252] ^ D[259];
assign r[97] = W[97] ^ D[253] ^ D[260];
assign r[98] = W[98] ^ D[254] ^ D[261];
assign r[99] = W[99] ^ D[255] ^ D[262];
assign r[100] = W[100] ^ D[256] ^ D[263];
assign r[101] = W[101] ^ D[257] ^ D[264];
assign r[102] = W[102] ^ D[258] ^ D[265];
assign r[103] = W[103] ^ D[259] ^ D[266];
assign r[104] = W[104] ^ D[260] ^ D[267];
assign r[105] = W[105] ^ D[261] ^ D[268];
assign r[106] = W[106] ^ D[262] ^ D[269];
assign r[107] = W[107] ^ D[263] ^ D[270];
assign r[108] = W[108] ^ D[264] ^ D[271];
assign r[109] = W[109] ^ D[265] ^ D[272];
assign r[110] = W[110] ^ D[266] ^ D[273];
assign r[111] = W[111] ^ D[267] ^ D[274];
assign r[112] = W[112] ^ D[268] ^ D[275];
assign r[113] = W[113] ^ D[269] ^ D[276];
assign r[114] = W[114] ^ D[270] ^ D[277];
assign r[115] = W[115] ^ D[271] ^ D[278];
assign r[116] = W[116] ^ D[272] ^ D[279];
assign r[117] = W[117] ^ D[273] ^ D[280];
assign r[118] = W[118] ^ D[274] ^ D[281];
assign r[119] = W[119] ^ D[275] ^ D[282];
assign r[120] = W[120] ^ D[276] ^ D[283];
assign r[121] = W[121] ^ D[277] ^ D[284];
assign r[122] = W[122] ^ D[278] ^ D[285];
assign r[123] = W[123] ^ D[279] ^ D[286];
assign r[124] = W[124] ^ D[280] ^ D[287];
assign r[125] = W[125] ^ D[281] ^ D[288];
assign r[126] = W[126] ^ D[282] ^ D[289];
assign r[127] = W[127] ^ D[283] ^ D[290];
assign r[128] = W[128] ^ D[284] ^ D[291];
assign r[129] = W[129] ^ D[285] ^ D[292];
assign r[130] = W[130] ^ D[286] ^ D[293];
assign r[131] = W[131] ^ D[287] ^ D[294];
assign r[132] = W[132] ^ D[288] ^ D[295];
assign r[133] = W[133] ^ D[289] ^ D[296];
assign r[134] = W[134] ^ D[290] ^ D[297];
assign r[135] = W[135] ^ D[291] ^ D[298];
assign r[136] = W[136] ^ D[292] ^ D[299];
assign r[137] = W[137] ^ D[293] ^ D[300];
assign r[138] = W[138] ^ D[294] ^ D[301];
assign r[139] = W[139] ^ D[295] ^ D[302];
assign r[140] = W[140] ^ D[296] ^ D[303];
assign r[141] = W[141] ^ D[297] ^ D[304];
assign r[142] = W[142] ^ D[298] ^ D[305];
assign r[143] = W[143] ^ D[299] ^ D[306];
assign r[144] = W[144] ^ D[300] ^ D[307];
assign r[145] = W[145] ^ D[301] ^ D[308];
assign r[146] = W[146] ^ D[302] ^ D[309];
assign r[147] = W[147] ^ D[303] ^ D[310];
assign r[148] = W[148] ^ D[304] ^ D[311];
assign r[149] = W[149] ^ D[305] ^ D[312];
assign r[150] = W[150] ^ D[306] ^ D[313];
assign r[151] = W[151] ^ D[307] ^ D[314];
assign r[152] = W[152] ^ D[308] ^ D[315];
assign r[153] = W[153] ^ D[309] ^ D[316];
assign r[154] = W[154] ^ D[310] ^ D[317];
assign r[155] = W[155] ^ D[311] ^ D[318];
assign r[156] = W[156] ^ D[312] ^ D[319];
assign r[157] = W[157] ^ D[313] ^ D[320];
assign r[158] = W[158] ^ D[314] ^ D[321];
assign r[159] = W[159] ^ D[315] ^ D[322];
assign r[160] = W[160] ^ D[316] ^ D[323];
assign r[161] = W[161] ^ D[317] ^ D[324];

//for i=162
assign r[162]=W[162]^D[318];
endmodule