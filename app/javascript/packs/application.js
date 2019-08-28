import "bootstrap";
import { mycheck } from "./checkbox";
import { initActionCable } from "../plugins/init_action_cable";
import { firstNight , otherNight, endOfNight } from "./night";

mycheck();
initActionCable();
firstNight();
otherNight();
