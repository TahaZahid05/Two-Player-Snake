
x
Command: %s
53*	vivadotcl2G
3synth_design -top Master_Game -part xc7a35tcpg236-12default:defaultZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7a35t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7a35t2default:defaultZ17-349h px� 
V
Loading part %s157*device2#
xc7a35tcpg236-12default:defaultZ21-403h px� 
�
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
22default:defaultZ8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
`
#Helper process launched with PID %s4824*oasys2
170882default:defaultZ8-7075h px� 
�
%s*synth2�
wStarting RTL Elaboration : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1028.227 ; gain = 0.000
2default:defaulth px� 
�
synthesizing module '%s'%s4497*oasys2
Master_Game2default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Master_Game.v2default:default2
32default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
PS2Receiver2default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/PS2Receiver.v2default:default2
22default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
	debouncer2default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/debouncer.v2default:default2
22default:default8@Z8-6157h px� 
_
%s
*synth2G
3	Parameter COUNT_MAX bound to: 19 - type: integer 
2default:defaulth p
x
� 
`
%s
*synth2H
4	Parameter COUNT_WIDTH bound to: 5 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	debouncer2default:default2
 2default:default2
12default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/debouncer.v2default:default2
22default:default8@Z8-6155h px� 
�
-case statement is not full and has no default155*oasys2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/PS2Receiver.v2default:default2
342default:default8@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
PS2Receiver2default:default2
 2default:default2
22default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/PS2Receiver.v2default:default2
22default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2(
Master_State_Machine2default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Master_State_Machine.v2default:default2
22default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2(
Master_State_Machine2default:default2
 2default:default2
32default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Master_State_Machine.v2default:default2
22default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2,
Navigation_State_Machine2default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Navigation_State_Machine.v2default:default2
22default:default8@Z8-6157h px� 
�
8referenced signal '%s' should be on the sensitivity list567*oasys2
state_snake2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Navigation_State_Machine.v2default:default2
172default:default8@Z8-567h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2,
Navigation_State_Machine2default:default2
 2default:default2
42default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Navigation_State_Machine.v2default:default2
22default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2!
Snake_control2default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Snake_control.v2default:default2
22default:default8@Z8-6157h px� 
[
%s
*synth2C
/	Parameter MaxY bound to: 120 - type: integer 
2default:defaulth p
x
� 
[
%s
*synth2C
/	Parameter MaxX bound to: 160 - type: integer 
2default:defaulth p
x
� 
a
%s
*synth2I
5	Parameter SnakeLength bound to: 27 - type: integer 
2default:defaulth p
x
� 
�
synthesizing module '%s'%s4497*oasys2#
Generic_counter2default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Generic_counter.v2default:default2
22default:default8@Z8-6157h px� 
c
%s
*synth2K
7	Parameter COUNTER_WIDTH bound to: 26 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2#
Generic_counter2default:default2
 2default:default2
52default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Generic_counter.v2default:default2
22default:default8@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
TRIG_OUT2default:default2#
Generic_counter2default:default2
	moveSnake2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Snake_control.v2default:default2
622default:default8@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
	moveSnake2default:default2#
Generic_counter2default:default2
62default:default2
52default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Snake_control.v2default:default2
622default:default8@Z8-7023h px� 
�
synthesizing module '%s'%s4497*oasys2
alphabetGen2default:default2
 2default:default2�
~C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/new/alphabetGen.v2default:default2
32default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
alphabetGen2default:default2
 2default:default2
62default:default2
12default:default2�
~C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/new/alphabetGen.v2default:default2
32default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2 
scoreDisplay2default:default2
 2default:default2�
C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/new/scoreDisplay.v2default:default2
12default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2 
scoreDisplay2default:default2
 2default:default2
72default:default2
12default:default2�
C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/new/scoreDisplay.v2default:default2
12default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2!
Snake_control2default:default2
 2default:default2
82default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Snake_control.v2default:default2
22default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2$
Target_Generator2default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Target_Generator.v2default:default2
12default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2$
Target_Generator2default:default2
 2default:default2
92default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Target_Generator.v2default:default2
12default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2!
VGA_Interface2default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/VGA_Interface.v2default:default2
22default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2

VGA_Driver2default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/VGA_Driver.v2default:default2
22default:default8@Z8-6157h px� 
j
%s
*synth2R
>	Parameter VertTimeToPulseWeidthEnd bound to: 10'b0000000010 
2default:defaulth p
x
� 
h
%s
*synth2P
<	Parameter VertTimeToBackPorchEnd bound to: 10'b0000011111 
2default:defaulth p
x
� 
j
%s
*synth2R
>	Parameter VertTimeToDisplayTimeEnd bound to: 10'b0111111111 
2default:defaulth p
x
� 
i
%s
*synth2Q
=	Parameter VertTimeToFrontPorchEnd bound to: 10'b1000001001 
2default:defaulth p
x
� 
i
%s
*synth2Q
=	Parameter HorzTimeToPulseWidthEnd bound to: 10'b0001100000 
2default:defaulth p
x
� 
h
%s
*synth2P
<	Parameter HorzTimeToBackPorchEnd bound to: 10'b0010010000 
2default:defaulth p
x
� 
j
%s
*synth2R
>	Parameter HorzTimeToDisplayTimeEnd bound to: 10'b1100010000 
2default:defaulth p
x
� 
i
%s
*synth2Q
=	Parameter HorzTimeToFrontPorchEnd bound to: 10'b1100100000 
2default:defaulth p
x
� 
�
synthesizing module '%s'%s4497*oasys23
Generic_counter__parameterized02default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Generic_counter.v2default:default2
22default:default8@Z8-6157h px� 
b
%s
*synth2J
6	Parameter COUNTER_WIDTH bound to: 2 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys23
Generic_counter__parameterized02default:default2
 2default:default2
92default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Generic_counter.v2default:default2
22default:default8@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
COUNT2default:default2#
Generic_counter2default:default2

CounterTo32default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/VGA_Driver.v2default:default2
382default:default8@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2

CounterTo32default:default2#
Generic_counter2default:default2
62default:default2
52default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/VGA_Driver.v2default:default2
382default:default8@Z8-7023h px� 
�
synthesizing module '%s'%s4497*oasys23
Generic_counter__parameterized12default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Generic_counter.v2default:default2
22default:default8@Z8-6157h px� 
c
%s
*synth2K
7	Parameter COUNTER_WIDTH bound to: 10 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys23
Generic_counter__parameterized12default:default2
 2default:default2
92default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Generic_counter.v2default:default2
22default:default8@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
TRIG_OUT2default:default2#
Generic_counter2default:default2 
CounterTo5202default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/VGA_Driver.v2default:default2
612default:default8@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2 
CounterTo5202default:default2#
Generic_counter2default:default2
62default:default2
52default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/VGA_Driver.v2default:default2
612default:default8@Z8-7023h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

VGA_Driver2default:default2
 2default:default2
102default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/VGA_Driver.v2default:default2
22default:default8@Z8-6155h px� 
�
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
92default:default2
ADDRV2default:default2
102default:default2

VGA_Driver2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/VGA_Interface.v2default:default2
232default:default8@Z8-689h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2!
VGA_Interface2default:default2
 2default:default2
112default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/VGA_Interface.v2default:default2
22default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2!
Score_Counter2default:default2
 2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Score_Counter.v2default:default2
22default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2!
Score_Counter2default:default2
 2default:default2
122default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Score_Counter.v2default:default2
22default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
timer2default:default2
 2default:default2�
xC:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/new/timer.v2default:default2
22default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
timer2default:default2
 2default:default2
132default:default2
12default:default2�
xC:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/new/timer.v2default:default2
22default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
Master_Game2default:default2
 2default:default2
142default:default2
12default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/sources_1/imports/new/Master_Game.v2default:default2
32default:default8@Z8-6155h px� 
�
%s*synth2�
yFinished RTL Elaboration : Time (s): cpu = 00:00:23 ; elapsed = 00:00:24 . Memory (MB): peak = 1239.301 ; gain = 211.074
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:25 ; elapsed = 00:00:26 . Memory (MB): peak = 1239.301 ; gain = 211.074
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:25 ; elapsed = 00:00:26 . Memory (MB): peak = 1239.301 ; gain = 211.074
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.4442default:default2
1239.3012default:default2
0.0002default:defaultZ17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
Parsing XDC File [%s]
179*designutils2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default8Z20-179h px� 
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[0]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
162default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
162default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[0]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
172default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
172default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[1]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
202default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
202default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[1]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
212default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
212default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[2]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
242default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
242default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[2]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
252default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
252default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[3]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
282default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
282default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[3]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
292default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
292default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[4]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
322default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
322default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[4]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
332default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
332default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[5]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
362default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
362default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[5]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
372default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
372default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[6]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
402default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
402default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[6]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
412default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
412default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[7]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
442default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
442default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2

HEX_OUT[7]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
452default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
452default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2!
SEG_SELECT[0]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1042default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1042default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2!
SEG_SELECT[0]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1052default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1052default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2!
SEG_SELECT[1]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1082default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1082default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2!
SEG_SELECT[1]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1092default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1092default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2!
SEG_SELECT[2]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1122default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1122default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2!
SEG_SELECT[2]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1132default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1132default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2!
SEG_SELECT[3]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1162default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1162default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2!
SEG_SELECT[3]2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1172default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1172default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
BTNC2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1262default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1262default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
BTND2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1272default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1272default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
BTNL2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1282default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1282default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
BTNR2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1292default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1292default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
BTNU2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1302default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1302default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
BTNC2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1312default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1312default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
BTND2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1322default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1322default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
BTNL2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1332default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1332default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
BTNR2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1342default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1342default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
BTNU2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1352default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default2
1352default:default8@Z17-55h px�
�
Finished Parsing XDC File [%s]
178*designutils2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2�
�C:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.srcs/constrs_1/imports/new/Snake_Constr.xdc2default:default21
.Xil/Master_Game_propImpl.xdc2default:defaultZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0072default:default2
1239.3012default:default2
0.0002default:defaultZ17-268h px� 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common24
 Constraint Validation Runtime : 2default:default2
00:00:002default:default2 
00:00:00.1042default:default2
1239.3012default:default2
0.0002default:defaultZ17-268h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:36 ; elapsed = 00:00:36 . Memory (MB): peak = 1239.301 ; gain = 211.074
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
J
%s
*synth22
Loading part: xc7a35tcpg236-1
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:36 ; elapsed = 00:00:36 . Memory (MB): peak = 1239.301 ; gain = 211.074
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Z
%s
*synth2B
.Start Applying 'set_property' XDC Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:36 ; elapsed = 00:00:36 . Memory (MB): peak = 1239.301 ; gain = 211.074
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2#
state_snake_reg2default:default2,
Navigation_State_Machine2default:defaultZ8-802h px� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2s
_                  iSTATE |                               00 |                               00
2default:defaulth p
x
� 
�
%s
*synth2s
_                 iSTATE2 |                               01 |                               01
2default:defaulth p
x
� 
�
%s
*synth2s
_                 iSTATE1 |                               10 |                               11
2default:defaulth p
x
� 
�
%s
*synth2s
_                 iSTATE0 |                               11 |                               10
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2#
state_snake_reg2default:default2

sequential2default:default2,
Navigation_State_Machine2default:defaultZ8-3354h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:50 ; elapsed = 00:00:51 . Memory (MB): peak = 1239.301 ; gain = 211.074
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input   32 Bit       Adders := 49    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   27 Bit       Adders := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   10 Bit       Adders := 454   
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    9 Bit       Adders := 615   
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    9 Bit       Adders := 49    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    8 Bit       Adders := 8     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    7 Bit       Adders := 12    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    5 Bit       Adders := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    4 Bit       Adders := 18    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    3 Bit       Adders := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    2 Bit       Adders := 2     
2default:defaulth p
x
� 
8
%s
*synth2 
+---XORs : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit         XORs := 8     
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               27 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               16 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               12 Bit    Registers := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               10 Bit    Registers := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                8 Bit    Registers := 58    
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                7 Bit    Registers := 56    
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                4 Bit    Registers := 7     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                3 Bit    Registers := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                2 Bit    Registers := 5     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 35    
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   27 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   23 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   12 Bit        Muxes := 2542  
2default:defaulth p
x
� 
X
%s
*synth2@
,	   3 Input   12 Bit        Muxes := 49    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   5 Input   12 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    8 Bit        Muxes := 134   
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    8 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   3 Input    8 Bit        Muxes := 8     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    7 Bit        Muxes := 39    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    7 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   5 Input    7 Bit        Muxes := 4     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   3 Input    7 Bit        Muxes := 8     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    4 Bit        Muxes := 39    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   5 Input    3 Bit        Muxes := 4     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    3 Bit        Muxes := 4     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    2 Bit        Muxes := 22    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    2 Bit        Muxes := 4     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   3 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    1 Bit        Muxes := 840   
2default:defaulth p
x
� 
X
%s
*synth2@
,	   5 Input    1 Bit        Muxes := 26    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    1 Bit        Muxes := 174   
2default:defaulth p
x
� 
X
%s
*synth2@
,	   3 Input    1 Bit        Muxes := 13    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   6 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   7 Input    1 Bit        Muxes := 3     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   8 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   9 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  10 Input    1 Bit        Muxes := 20    
2default:defaulth p
x
� 
X
%s
*synth2@
,	  11 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  12 Input    1 Bit        Muxes := 4     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  13 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  14 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  15 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  16 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  17 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  18 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  19 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  20 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  21 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  22 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2j
VPart Resources:
DSPs: 90 (col length:60)
BRAMs: 100 (col length: RAMB18 60 RAMB36 30)
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:01:59 ; elapsed = 00:02:01 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
R
%s
*synth2:
&Start Applying XDC Timing Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:02:06 ; elapsed = 00:02:08 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
}Finished Timing Optimization : Time (s): cpu = 00:02:06 ; elapsed = 00:02:08 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
|Finished Technology Mapping : Time (s): cpu = 00:02:09 ; elapsed = 00:02:11 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
vFinished IO Insertion : Time (s): cpu = 00:02:13 ; elapsed = 00:02:15 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:02:13 ; elapsed = 00:02:16 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start Rebuilding User Hierarchy
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:02:14 ; elapsed = 00:02:16 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Renaming Generated Ports
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:02:14 ; elapsed = 00:02:16 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:02:14 ; elapsed = 00:02:17 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
J
%s
*synth22
Start Renaming Generated Nets
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:02:14 ; elapsed = 00:02:17 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
J
%s
*synth22
| |BlackBox name |Instances |
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px� 
D
%s*synth2,
+------+-------+------+
2default:defaulth px� 
D
%s*synth2,
|      |Cell   |Count |
2default:defaulth px� 
D
%s*synth2,
+------+-------+------+
2default:defaulth px� 
D
%s*synth2,
|1     |BUFG   |     1|
2default:defaulth px� 
D
%s*synth2,
|2     |CARRY4 |   575|
2default:defaulth px� 
D
%s*synth2,
|3     |LUT1   |   371|
2default:defaulth px� 
D
%s*synth2,
|4     |LUT2   |  1872|
2default:defaulth px� 
D
%s*synth2,
|5     |LUT3   |   721|
2default:defaulth px� 
D
%s*synth2,
|6     |LUT4   |  1450|
2default:defaulth px� 
D
%s*synth2,
|7     |LUT5   |   534|
2default:defaulth px� 
D
%s*synth2,
|8     |LUT6   |  4414|
2default:defaulth px� 
D
%s*synth2,
|9     |MUXF7  |     1|
2default:defaulth px� 
D
%s*synth2,
|10    |FDCE   |   118|
2default:defaulth px� 
D
%s*synth2,
|11    |FDPE   |    71|
2default:defaulth px� 
D
%s*synth2,
|12    |FDRE   |   883|
2default:defaulth px� 
D
%s*synth2,
|13    |FDSE   |    15|
2default:defaulth px� 
D
%s*synth2,
|14    |IBUF   |     3|
2default:defaulth px� 
D
%s*synth2,
|15    |OBUF   |    14|
2default:defaulth px� 
D
%s*synth2,
+------+-------+------+
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:02:14 ; elapsed = 00:02:17 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
r
%s
*synth2Z
FSynthesis finished with 0 errors, 0 critical warnings and 0 warnings.
2default:defaulth p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:01:42 ; elapsed = 00:02:11 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:02:14 ; elapsed = 00:02:17 . Memory (MB): peak = 1677.527 ; gain = 649.301
2default:defaulth p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:012default:default2 
00:00:00.1472default:default2
1677.5272default:default2
0.0002default:defaultZ17-268h px� 
g
-Analyzing %s Unisim elements for replacement
17*netlist2
5762default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0022default:default2
1677.5272default:default2
0.0002default:defaultZ17-268h px� 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px� 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
502default:default2
422default:default2
342default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:02:212default:default2
00:02:262default:default2
1677.5272default:default2
649.3012default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2�
zC:/Users/ddddd/OneDrive/Desktop/Semester 3/DLD/Project/Two-Player-Snake/snake_game/snake_game.runs/synth_1/Master_Game.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2�
lExecuting : report_utilization -file Master_Game_utilization_synth.rpt -pb Master_Game_utilization_synth.pb
2default:defaulth px� 
�
Exiting %s at %s...
206*common2
Vivado2default:default2,
Fri Dec 13 06:28:36 20242default:defaultZ17-206h px� 


End Record