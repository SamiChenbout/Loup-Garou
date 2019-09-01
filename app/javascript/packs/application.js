import "bootstrap";
import { mycheckTwo, mycheckOne, mycheckVoteLoup, mycheckVote } from "./checkbox";
import { initActionCable } from "../plugins/init_action_cable";
import { dayScript } from "../plugins/day_script";
import { initActionCableLoup } from "../plugins/init_action_cable_loup";
import { cupidon, chasseur, sorciere, loup, voyante } from "./night"

mycheckTwo();
mycheckVote();
mycheckVoteLoup();
mycheckOne();
initActionCable();
initActionCableLoup();
//dayScript();
//cupidon();
//chasseur();
//sorciere();
//loup();
//voyante();
