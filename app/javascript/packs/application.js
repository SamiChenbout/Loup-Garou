import "bootstrap";
import { mycheck } from "./checkbox";
import { initActionCable } from "../plugins/init_action_cable";
import { initActionCableLoup } from "../plugins/init_action_cable_loup";
import { timer } from "../plugins/timer";
import { cupidon, chasseur, sorciere, loup, voyante } from "./night"

mycheck();
initActionCable();
initActionCableLoup();
timer();
