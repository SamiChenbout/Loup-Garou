import "bootstrap";
import { mycheck } from "./checkbox";
import { initActionCable } from "../plugins/init_action_cable";
import { timer } from "../plugins/timer";
import { cupidon } from "./night"

mycheck();
initActionCable();
cupidon();
timer();
