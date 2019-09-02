import "bootstrap";
import { mycheckTwo, mycheckOne, mycheckVoteLoup, mycheckVote } from "./checkbox";
import { initActionCable } from "../plugins/init_action_cable";
import { dayScript } from "../plugins/day_script";
import { initActionCableLoup } from "../plugins/init_action_cable_loup";
import { cupidon, chasseur, sorciere, loup, voyante } from "./night";
import { modalRegle, modalParams } from "./modal";
import { animation } from "../plugins/animation_timeout";
import { move } from "../plugins/progress_bar";

mycheckTwo();
modalRegle();
modalParams();
mycheckVote();
mycheckVoteLoup();
mycheckOne();
initActionCable();
initActionCableLoup();
animation();
move();
//dayScript();
//cupidon();
//chasseur();
//sorciere();
//loup();
//voyante();
