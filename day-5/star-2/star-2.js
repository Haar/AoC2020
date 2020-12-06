let readline = require("readline");
let fs = require("fs");

function range(start, end) {
    return Array(end - start + 1).fill().map((_, idx) => start + idx)
}

// FFBBBBBLLR
const weirdToSeatID = (input) => {
  let binary =
    input.
      replace(/B/g, "1").
      replace(/F/g, "0").
      replace(/R/g, "1").
      replace(/L/g, "0");

  let row = parseInt(binary.slice(0, 7), 2);
  let column = parseInt(binary.slice(-3), 2);

  return row * 8 + column;
}

async function main() {
  const lines = readline.createInterface({
    input: fs.createReadStream("./input.txt")
  })

  let seatIDs = [];

  for await (const line of lines) {
    seatIDs.push(weirdToSeatID(line));
  }

  console.log(range(80, 926).filter((x) => !seatIDs.includes(x)))
}

main();
