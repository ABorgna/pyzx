// EXPECTED_REWIRING [0 1 2 3 4 5 7 6 8 9 10 11 12 13 14 15]
// CURRENT_REWIRING [5 2 1 4 11 0 6 15 10 13 7 3 14 12 9 8]
OPENQASM 2.0;
include "qelib1.inc";
qreg q[16];
rz(-1.5707963267948966*pi) q[3];
rx(1.5707963267948966*pi) q[3];
rz(1.5707963267948966*pi) q[3];
rz(-1.5707963267948966*pi) q[10];
rx(1.5707963267948966*pi) q[10];
cz q[10], q[11];
rz(-1.5707963267948966*pi) q[6];
rx(1.5707963267948966*pi) q[6];
cz q[6], q[1];
rz(1.5707963267948966*pi) q[7];
rx(1.5707963267948966*pi) q[7];
rz(-2.4242502557007715*pi) q[7];
rx(-1.5707963267948966*pi) q[7];
rz(-0.30285850843138395*pi) q[8];
rx(1.5707963267948966*pi) q[8];
cz q[7], q[8];
rx(1.5707963267948966*pi) q[7];
rx(-1.5707963267948966*pi) q[8];
cz q[7], q[8];
rx(1.5707963267948966*pi) q[8];
rz(2.424250255700772*pi) q[8];
rx(-1.5707963267948966*pi) q[8];
rz(-1.5707963267948966*pi) q[8];
rz(-1.5707963267948966*pi) q[15];
rx(1.5707963267948966*pi) q[15];
rz(1.5707963267948966*pi) q[15];
rz(-1.5707963267948966*pi) q[9];
rx(1.5707963267948966*pi) q[9];
cz q[9], q[14];
cz q[15], q[8];
rz(1.674236967864048*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(1.4189783790674746*pi) q[6];
rx(-1.5707963267948966*pi) q[6];
rz(1.7299749707906902*pi) q[7];
rx(1.5707963267948966*pi) q[7];
rz(0.5143224457080826*pi) q[7];
rx(-1.5707963267948966*pi) q[7];
rz(-1.709664301929612*pi) q[7];
cz q[7], q[6];
rz(1.6366529270088535*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(-0.8538646389853684*pi) q[7];
rx(-1.5707963267948966*pi) q[7];
cz q[7], q[6];
rx(-1.5707963267948966*pi) q[6];
rx(1.5707963267948966*pi) q[7];
cz q[7], q[6];
rz(1.5707963267948966*pi) q[1];
rx(1.5707963267948966*pi) q[1];
rz(1.5707963267948966*pi) q[1];
rz(-0.6542456812873576*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(0.9242262418970197*pi) q[6];
rx(-1.5707963267948966*pi) q[6];
rz(0.6463506146747173*pi) q[6];
rz(1.674236967864048*pi) q[9];
rx(1.5707963267948966*pi) q[9];
rz(1.4189783790674746*pi) q[9];
rx(-1.5707963267948966*pi) q[9];
rz(-3.075736053375836*pi) q[9];
rz(-3.0381520125206416*pi) q[14];
rx(1.5707963267948966*pi) q[14];
rz(1.4189783790674746*pi) q[14];
rx(-1.5707963267948966*pi) q[14];
rz(-1.784329049938982*pi) q[15];
rx(1.5707963267948966*pi) q[15];
rz(2.0779896335268955*pi) q[15];
rx(-1.5707963267948966*pi) q[15];
cz q[15], q[14];
rz(1.6366529270088535*pi) q[14];
rx(1.5707963267948966*pi) q[14];
rz(-2.381184772407101*pi) q[15];
rx(-1.5707963267948966*pi) q[15];
cz q[15], q[14];
rx(-1.5707963267948966*pi) q[14];
rx(1.5707963267948966*pi) q[15];
cz q[15], q[14];
rx(1.5707963267948966*pi) q[14];
cz q[14], q[9];
rz(-1.5707963267948966*pi) q[9];
rx(1.5707963267948966*pi) q[9];
rx(-1.5707963267948966*pi) q[14];
cz q[14], q[9];
rx(-1.5707963267948966*pi) q[9];
rx(1.5707963267948966*pi) q[14];
cz q[14], q[9];
cz q[6], q[1];
rx(1.5707963267948966*pi) q[9];
rz(1.5707963267948966*pi) q[9];
rz(-1.164582056715158*pi) q[14];
rx(1.5707963267948966*pi) q[14];
rz(0.16538560610687736*pi) q[14];
rx(-1.5707963267948966*pi) q[14];
cz q[14], q[13];
rz(-1.1645820567151595*pi) q[15];
rx(1.5707963267948966*pi) q[15];
rz(0.1653856061068779*pi) q[15];
rx(-1.5707963267948966*pi) q[15];
rz(-0.5146654427613733*pi) q[15];
rz(-2.547912551844373*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(2.958108965734335*pi) q[6];
rx(-1.5707963267948966*pi) q[6];
cz q[9], q[6];
rz(2.238207199899204*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(-1.5707963267948966*pi) q[9];
rx(-1.5707963267948966*pi) q[9];
cz q[9], q[6];
rx(-1.5707963267948966*pi) q[6];
rx(1.5707963267948966*pi) q[9];
cz q[9], q[6];
rz(-0.2135327231440851*pi) q[10];
rx(1.5707963267948966*pi) q[10];
rz(2.077989633526896*pi) q[10];
rx(-1.5707963267948966*pi) q[10];
rz(-0.8103884456122047*pi) q[10];
rx(-1.5707963267948966*pi) q[9];
cz q[10], q[9];
rx(1.5707963267948966*pi) q[9];
rz(-1.5707963267948966*pi) q[10];
rx(-1.5707963267948966*pi) q[10];
cz q[10], q[9];
rx(-1.5707963267948966*pi) q[9];
rx(1.5707963267948966*pi) q[10];
cz q[10], q[9];
rz(1.5707963267948966*pi) q[11];
rx(1.5707963267948966*pi) q[11];
cz q[11], q[4];
rz(1.5707963267948966*pi) q[4];
rx(1.5707963267948966*pi) q[4];
rx(-1.5707963267948966*pi) q[11];
cz q[4], q[11];
rz(-1.1645820567151592*pi) q[10];
rx(1.5707963267948966*pi) q[10];
rz(0.16538560610687794*pi) q[10];
rx(-1.5707963267948966*pi) q[10];
rz(2.730367851897572*pi) q[10];
cz q[10], q[11];
rz(3.141592653589793*pi) q[4];
rx(1.5707963267948966*pi) q[4];
cz q[4], q[3];
rz(-1.5707963267948966*pi) q[12];
rx(1.5707963267948966*pi) q[12];
cz q[11], q[12];
cz q[10], q[5];
rz(3.141592653589793*pi) q[13];
cz q[13], q[10];
rz(-0.6917816367331454*pi) q[4];
rx(1.5707963267948966*pi) q[4];
rz(1.4691534057995945*pi) q[4];
rx(-1.5707963267948966*pi) q[4];
rz(-1.1901364812605806*pi) q[11];
rx(1.5707963267948966*pi) q[11];
rz(0.9798201706807415*pi) q[11];
rx(-1.5707963267948966*pi) q[11];
rz(1.647636888906265*pi) q[11];
cz q[11], q[4];
rz(2.9774101730516973*pi) q[4];
rx(1.5707963267948966*pi) q[4];
rx(-1.5707963267948966*pi) q[11];
cz q[11], q[4];
rx(-1.5707963267948966*pi) q[4];
rx(1.5707963267948966*pi) q[11];
cz q[11], q[4];
rz(0.10344064106915161*pi) q[5];
rx(1.5707963267948966*pi) q[5];
rz(1.4189783790674746*pi) q[5];
rx(-1.5707963267948966*pi) q[5];
rx(1.5707963267948966*pi) q[6];
cz q[6], q[5];
rz(1.6366529270088535*pi) q[5];
rx(1.5707963267948966*pi) q[5];
rx(-1.5707963267948966*pi) q[6];
cz q[6], q[5];
rx(-1.5707963267948966*pi) q[5];
rx(1.5707963267948966*pi) q[6];
cz q[6], q[5];
rz(-1.1645820567151592*pi) q[7];
rx(1.5707963267948966*pi) q[7];
rz(0.16538560610687794*pi) q[7];
rx(-1.5707963267948966*pi) q[7];
rz(2.730367851897572*pi) q[7];
cz q[7], q[0];
rz(1.4564375502462912*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(1.4269954866939933*pi) q[6];
rx(-1.5707963267948966*pi) q[6];
rz(-2.5749313944290577*pi) q[6];
rz(1.4673556857257455*pi) q[7];
rx(1.5707963267948966*pi) q[7];
cz q[7], q[6];
cz q[15], q[14];
rz(2.063227648138892*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(0.18348368785545774*pi) q[6];
rx(-1.5707963267948966*pi) q[6];
rz(0.6674108731043047*pi) q[6];
rz(-1.6742369678640472*pi) q[7];
rx(1.5707963267948966*pi) q[7];
rz(-1.4189783790674753*pi) q[7];
rx(1.5707963267948966*pi) q[7];
rz(1.0537901828308984*pi) q[8];
rx(1.5707963267948966*pi) q[8];
rz(1.3844841619731474*pi) q[8];
rx(-1.5707963267948966*pi) q[8];
rz(2.4361413542909993*pi) q[8];
cz q[8], q[7];
rz(1.6366529270088535*pi) q[7];
rx(1.5707963267948966*pi) q[7];
rx(-1.5707963267948966*pi) q[8];
cz q[8], q[7];
rx(-1.5707963267948966*pi) q[7];
rx(1.5707963267948966*pi) q[8];
cz q[8], q[7];
rz(-0.6542456812873576*pi) q[5];
rx(1.5707963267948966*pi) q[5];
rz(0.9242262418970197*pi) q[5];
rx(-1.5707963267948966*pi) q[5];
cz q[5], q[2];
rx(1.5707963267948966*pi) q[7];
cz q[7], q[6];
rz(-1.5707963267948966*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rx(-1.5707963267948966*pi) q[7];
cz q[7], q[6];
rx(-1.5707963267948966*pi) q[6];
rx(1.5707963267948966*pi) q[7];
cz q[7], q[6];
rz(-2.3918013978459243*pi) q[5];
rx(1.5707963267948966*pi) q[5];
rz(1.4189783790674746*pi) q[5];
rx(-1.5707963267948966*pi) q[5];
rx(1.5707963267948966*pi) q[6];
cz q[6], q[5];
rz(1.6366529270088535*pi) q[5];
rx(1.5707963267948966*pi) q[5];
rx(-1.5707963267948966*pi) q[6];
cz q[6], q[5];
rx(-1.5707963267948966*pi) q[5];
rx(1.5707963267948966*pi) q[6];
cz q[6], q[5];
rx(1.5707963267948966*pi) q[9];
rz(1.5707963267948966*pi) q[9];
rz(-0.08424221951956504*pi) q[8];
rx(1.5707963267948966*pi) q[8];
rz(1.9865099124411159*pi) q[8];
rx(-1.5707963267948966*pi) q[8];
rz(2.4250786833229547*pi) q[8];
rz(0.45946393016486703*pi) q[15];
rx(1.5707963267948966*pi) q[15];
rz(1.796605951854737*pi) q[15];
rx(-1.5707963267948966*pi) q[15];
cz q[8], q[15];
rx(-1.5707963267948966*pi) q[8];
rz(-0.15945551514676204*pi) q[15];
rx(1.5707963267948966*pi) q[15];
cz q[8], q[15];
rx(1.5707963267948966*pi) q[8];
rx(-1.5707963267948966*pi) q[15];
cz q[8], q[15];
rz(0.6128972238194015*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(1.6344029625411813*pi) q[6];
rx(-1.5707963267948966*pi) q[6];
rz(-1.6009734199202523*pi) q[9];
rx(1.5707963267948966*pi) q[9];
rz(1.3565964972586744*pi) q[9];
rx(-1.5707963267948966*pi) q[9];
rz(3.140764277659598*pi) q[9];
cz q[9], q[6];
rz(-0.040720426712669955*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rx(-1.5707963267948966*pi) q[9];
cz q[9], q[6];
rx(-1.5707963267948966*pi) q[6];
rx(1.5707963267948966*pi) q[9];
cz q[9], q[6];
rz(1.5707963267948966*pi) q[1];
rx(1.5707963267948966*pi) q[1];
rz(2.426231001281402*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(2.192671757395102*pi) q[6];
rx(-1.5707963267948966*pi) q[6];
cz q[6], q[1];
rz(2.828692204091942*pi) q[0];
rx(1.5707963267948966*pi) q[0];
rz(1.5367057165242843*pi) q[0];
rx(-1.5707963267948966*pi) q[0];
rz(-0.7299630044330966*pi) q[7];
rx(1.5707963267948966*pi) q[7];
rz(1.0729841522086652*pi) q[7];
rx(-1.5707963267948966*pi) q[7];
rz(0.5667722158444656*pi) q[7];
cz q[7], q[0];
rz(-0.30291686084863567*pi) q[0];
rx(1.5707963267948966*pi) q[0];
rx(-1.5707963267948966*pi) q[7];
cz q[7], q[0];
rx(-1.5707963267948966*pi) q[0];
rx(1.5707963267948966*pi) q[7];
cz q[7], q[0];
rz(1.565910688675692*pi) q[8];
rx(1.5707963267948966*pi) q[8];
rz(1.213541497033622*pi) q[8];
rx(-1.5707963267948966*pi) q[8];
rz(0.013969995098872492*pi) q[8];
rz(0.8965878265811407*pi) q[9];
rx(1.5707963267948966*pi) q[9];
rz(0.6600203156989194*pi) q[9];
rx(-1.5707963267948966*pi) q[9];
rz(0.7911544093092393*pi) q[9];
cz q[9], q[8];
rz(-0.17424563305096763*pi) q[8];
rx(1.5707963267948966*pi) q[8];
rz(1.8879816975807362*pi) q[9];
rx(-1.5707963267948966*pi) q[9];
cz q[9], q[8];
rx(-1.5707963267948966*pi) q[8];
rx(1.5707963267948966*pi) q[9];
cz q[9], q[8];
rz(-0.6971207428145706*pi) q[10];
rx(1.5707963267948966*pi) q[10];
rz(0.18348368785545793*pi) q[10];
rx(-1.5707963267948966*pi) q[10];
rz(-2.5400383806994427*pi) q[10];
rz(-1.456315917539216*pi) q[11];
rx(1.5707963267948966*pi) q[11];
rz(1.72592706471651*pi) q[11];
rx(-1.5707963267948966*pi) q[11];
rz(0.6397677878325728*pi) q[11];
cz q[11], q[10];
rz(1.6366529270088535*pi) q[10];
rx(1.5707963267948966*pi) q[10];
rz(0.42382910291395604*pi) q[11];
rx(-1.5707963267948966*pi) q[11];
cz q[11], q[10];
rx(-1.5707963267948966*pi) q[10];
rx(1.5707963267948966*pi) q[11];
cz q[11], q[10];
rz(-1.1645820567151592*pi) q[9];
rx(1.5707963267948966*pi) q[9];
rz(0.16538560610687794*pi) q[9];
rx(-1.5707963267948966*pi) q[9];
rz(2.730367851897572*pi) q[9];
rz(-0.6542456812873576*pi) q[10];
rx(1.5707963267948966*pi) q[10];
rz(0.9242262418970197*pi) q[10];
rx(-1.5707963267948966*pi) q[10];
cz q[10], q[9];
rz(1.674236967864048*pi) q[12];
rx(1.5707963267948966*pi) q[12];
rz(1.4189783790674746*pi) q[12];
rx(-1.5707963267948966*pi) q[12];
rz(-1.7843290499389806*pi) q[13];
rx(-1.5707963267948966*pi) q[13];
rz(1.0636030200628974*pi) q[13];
rx(-1.5707963267948966*pi) q[13];
cz q[13], q[12];
rz(1.6366529270088535*pi) q[12];
rx(1.5707963267948966*pi) q[12];
rz(0.760407881182692*pi) q[13];
rx(-1.5707963267948966*pi) q[13];
cz q[13], q[12];
rx(-1.5707963267948966*pi) q[12];
rx(1.5707963267948966*pi) q[13];
cz q[13], q[12];
rz(2.217146941469614*pi) q[10];
rx(1.5707963267948966*pi) q[10];
rz(1.9770105968746374*pi) q[13];
rx(1.5707963267948966*pi) q[13];
rz(2.9762070474829163*pi) q[13];
rx(-1.5707963267948966*pi) q[13];
cz q[13], q[10];
rz(-1.5684556255922728*pi) q[14];
rx(1.5707963267948966*pi) q[14];
rz(1.7571084916166466*pi) q[14];
rx(-1.5707963267948966*pi) q[14];
rz(0.8653450274961034*pi) q[14];
rz(1.467355685725745*pi) q[10];
rx(-1.5707963267948966*pi) q[10];
rz(1.4189783790674746*pi) q[10];
rx(-1.5707963267948966*pi) q[10];
rz(-3.075736053375836*pi) q[10];
rz(2.761369489712264*pi) q[11];
rx(1.5707963267948966*pi) q[11];
rz(1.9641888827222767*pi) q[11];
rx(-1.5707963267948966*pi) q[11];
rz(-0.9438241621069082*pi) q[11];
rz(0.33376318482718753*pi) q[1];
rx(1.5707963267948966*pi) q[1];
rz(1.7540308819920556*pi) q[1];
rx(-1.5707963267948966*pi) q[1];
rz(-2.5680569614173803*pi) q[2];
rx(1.5707963267948966*pi) q[2];
rz(1.9593361811591603*pi) q[2];
rx(-1.5707963267948966*pi) q[2];
rz(-2.2361698764330535*pi) q[2];
cz q[2], q[1];
rz(2.24953343881369*pi) q[1];
rx(1.5707963267948966*pi) q[1];
rx(-1.5707963267948966*pi) q[2];
cz q[2], q[1];
rx(-1.5707963267948966*pi) q[1];
rx(1.5707963267948966*pi) q[2];
cz q[2], q[1];
rz(1.4568827407890372*pi) q[4];
rx(1.5707963267948966*pi) q[4];
rz(2.5462330166281375*pi) q[4];
rx(-1.5707963267948966*pi) q[4];
rz(-0.6542456812873576*pi) q[5];
rx(1.5707963267948966*pi) q[5];
rz(0.9242262418970197*pi) q[5];
rx(-1.5707963267948966*pi) q[5];
cz q[5], q[4];
rz(-0.4354196809062758*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(1.796102879828331*pi) q[7];
rx(1.5707963267948966*pi) q[7];
rz(1.027894806501215*pi) q[7];
rx(-1.5707963267948966*pi) q[7];
cz q[6], q[7];
rx(1.5707963267948966*pi) q[6];
rz(-0.35564867797448*pi) q[7];
rx(-1.5707963267948966*pi) q[7];
cz q[6], q[7];
rz(-0.1034406410691524*pi) q[9];
rz(0.05267051292929792*pi) q[5];
rx(1.5707963267948966*pi) q[5];
rz(0.18348368785545832*pi) q[5];
rx(-1.5707963267948966*pi) q[5];
rz(0.6674108731043076*pi) q[5];
rx(1.5707963267948966*pi) q[6];
rz(0.8954580851625985*pi) q[6];
rx(-1.5707963267948966*pi) q[6];
cz q[6], q[9];
rz(-2.7303678518975683*pi) q[13];
rx(1.5707963267948966*pi) q[13];
rz(1.7226142745223183*pi) q[13];
rx(-1.5707963267948966*pi) q[13];
cz q[14], q[13];
rz(-1.5049397265809379*pi) q[13];
rx(1.5707963267948966*pi) q[13];
rz(-1.5707963267948966*pi) q[14];
rx(-1.5707963267948966*pi) q[14];
cz q[14], q[13];
rx(-1.5707963267948966*pi) q[13];
rx(1.5707963267948966*pi) q[14];
cz q[14], q[13];
rz(-0.49347124254254915*pi) q[15];
rx(1.5707963267948966*pi) q[15];
rz(2.3785063083850835*pi) q[15];
rx(-1.5707963267948966*pi) q[15];
rz(2.8032565763694643*pi) q[15];
cz q[11], q[10];
rz(-1.5707963267948966*pi) q[10];
rx(1.5707963267948966*pi) q[10];
rz(-1.5707963267948966*pi) q[11];
rx(-1.5707963267948966*pi) q[11];
cz q[11], q[10];
rx(-1.5707963267948966*pi) q[10];
rx(1.5707963267948966*pi) q[11];
cz q[11], q[10];
rz(-0.6542456812873576*pi) q[12];
rx(1.5707963267948966*pi) q[12];
rz(0.9242262418970197*pi) q[12];
rx(-1.5707963267948966*pi) q[12];
rz(0.6463506146747173*pi) q[12];
rz(-0.6542456812873576*pi) q[8];
rx(1.5707963267948966*pi) q[8];
rz(0.9242262418970197*pi) q[8];
rx(-1.5707963267948966*pi) q[8];
rz(-2.495242038915076*pi) q[8];
rz(-1.1645820567151632*pi) q[14];
rx(1.5707963267948966*pi) q[14];
rz(0.165385606106878*pi) q[14];
rx(-1.5707963267948966*pi) q[14];
cz q[14], q[15];
rz(-0.6542456812873576*pi) q[10];
rx(1.5707963267948966*pi) q[10];
rz(0.9242262418970197*pi) q[10];
rx(-1.5707963267948966*pi) q[10];
rz(-2.495242038915076*pi) q[10];
rz(1.4564375502462912*pi) q[11];
rx(1.5707963267948966*pi) q[11];
rz(1.426995486693992*pi) q[11];
rx(-1.5707963267948966*pi) q[11];
cz q[11], q[12];
rz(2.7467136196496336*pi) q[2];
rx(1.5707963267948966*pi) q[2];
rz(0.9923747253053439*pi) q[2];
rx(-1.5707963267948966*pi) q[2];
rz(-1.5707963267948966*pi) q[3];
rx(1.5707963267948966*pi) q[3];
cz q[2], q[3];
rz(0.213532723144084*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(1.0636030200628972*pi) q[6];
rx(-1.5707963267948966*pi) q[6];
cz q[6], q[5];
rz(-1.5707963267948966*pi) q[5];
rx(1.5707963267948966*pi) q[5];
rz(0.760407881182692*pi) q[6];
rx(-1.5707963267948966*pi) q[6];
cz q[6], q[5];
rx(-1.5707963267948966*pi) q[5];
rx(1.5707963267948966*pi) q[6];
cz q[6], q[5];
rz(-1.7055917968437595*pi) q[3];
rx(1.5707963267948966*pi) q[3];
rz(1.052822223088234*pi) q[4];
rx(1.5707963267948966*pi) q[4];
rz(2.790250647819161*pi) q[4];
rx(-1.5707963267948966*pi) q[4];
cz q[3], q[4];
rz(-1.5707963267948966*pi) q[3];
rx(-1.5707963267948966*pi) q[3];
rx(1.5707963267948966*pi) q[4];
cz q[3], q[4];
rx(1.5707963267948966*pi) q[3];
cz q[3], q[4];
cz q[11], q[10];
rz(1.5707963267948966*pi) q[4];
rx(1.5707963267948966*pi) q[4];
rz(-0.6542456812873576*pi) q[5];
rx(1.5707963267948966*pi) q[5];
rz(0.9242262418970197*pi) q[5];
rx(-1.5707963267948966*pi) q[5];
cz q[5], q[4];
rz(2.217146941469614*pi) q[5];
rx(-1.5707963267948966*pi) q[5];
rz(1.5707963267948966*pi) q[10];
rx(1.5707963267948966*pi) q[10];
cz q[10], q[5];
cz q[8], q[15];
rz(2.4369136132601925*pi) q[0];
rx(1.5707963267948966*pi) q[0];
rz(1.9482380274910174*pi) q[0];
rx(-1.5707963267948966*pi) q[0];
rz(-2.8709813168528537*pi) q[0];
rz(-0.585509363283681*pi) q[1];
rx(1.5707963267948966*pi) q[1];
rz(0.7553244583239356*pi) q[1];
rx(-1.5707963267948966*pi) q[1];
rz(1.4470120338558727*pi) q[1];
rz(-1.1530933826995176*pi) q[2];
rx(1.5707963267948966*pi) q[2];
rz(1.5707963267948966*pi) q[2];
rz(-1.2194543210242632*pi) q[3];
rx(1.5707963267948966*pi) q[3];
rz(1.5707963267948966*pi) q[3];
rz(3.0067971835409195*pi) q[4];
rz(-1.5707963267948966*pi) q[5];
rz(-1.1645820567151595*pi) q[6];
rx(1.5707963267948966*pi) q[6];
rz(0.1653856061068779*pi) q[6];
rx(-1.5707963267948966*pi) q[6];
rz(-0.5146654427613733*pi) q[6];
rx(1.5707963267948966*pi) q[7];
rz(0.5109604806219759*pi) q[7];
rx(-1.5707963267948966*pi) q[7];
rz(-1.5707963267948966*pi) q[7];
rz(-1.5707963267948966*pi) q[8];
rx(-1.5707963267948966*pi) q[8];
rz(1.5707963267948966*pi) q[8];
rx(-1.5707963267948966*pi) q[10];
rz(1.5707963267948966*pi) q[10];
rz(-1.4888199713396473*pi) q[11];
rx(-1.5707963267948966*pi) q[11];
rz(1.5707963267948966*pi) q[11];
rz(3.141592653589793*pi) q[12];
rz(-0.6542456812873576*pi) q[13];
rx(1.5707963267948966*pi) q[13];
rz(0.9242262418970197*pi) q[13];
rx(-1.5707963267948966*pi) q[13];
rz(-2.495242038915076*pi) q[13];
rz(1.0561308840335282*pi) q[14];
rx(1.5707963267948966*pi) q[14];
rz(-1.5707963267948966*pi) q[14];