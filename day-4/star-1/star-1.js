let readline = require("readline");
let fs = require("fs");

class Passport {
  // ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm
  constructor(fields) {
    this.fields =
      Object.fromEntries(
        fields.split(" ").map((part) => part.split(":"))
    )

    this.fields.cid = this.fields.cid || "irrelevant";
  }

  isValid() {
    return Object.keys(this.fields).length > 7;
  }
}

// let passport = new Passport("ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm")

async function main() {
  const lines = readline.createInterface({
    input: fs.createReadStream("./input.txt")
  })

  let buffer = [];
  let passports = [];

  for await (const line of lines) {
    if (line == "") {
      passports.push(
        new Passport(buffer.join(" "))
      )

      buffer = [];
    } else {
      buffer.push(line)
    }
  }

  console.log(
    passports.filter((passport) => passport.isValid()).length
  );
}

main()
