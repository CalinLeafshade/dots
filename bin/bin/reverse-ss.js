const { spawn, exec } = require("child_process");

const ev = spawn("xinput", ["test-xi2", "--root"]);

const IDLE = 0;
const WORKING = 1;

const IDLE_TIME = 120; // 2 minutes
const WORKING_TIME = 3600; // 1 hour

let status = IDLE;
let timeChange = new Date();
let lastEvent = new Date();

ev.stdout.on("data", () => {
  lastEvent = new Date();
  if (status === IDLE) {
    console.log("Raising to working");
    status = WORKING;
    timeChange = new Date(lastEvent);
  }
});

function triggerBreak() {
  exec('notify-send "Take a break"');
}

setInterval(() => {
  const now = new Date();
  const dtSinceChange = (now.getTime() - timeChange.getTime()) / 1000;
  const dtSinceEvent = (now.getTime() - lastEvent.getTime()) / 1000;

  if (status === WORKING && dtSinceEvent > IDLE_TIME) {
    console.log("Dropping to idle");
    status = IDLE;
    timeChange = new Date();
  } else if (status === WORKING && dtSinceChange > WORKING_TIME) {
    console.log("Triggering");
    status = IDLE;
    triggerBreak();
  }
}, 1000);
