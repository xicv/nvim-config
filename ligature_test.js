// Test ligatures in your terminal + nvim setup
const arrow = (x) => x >= 10 && x <= 100;
const result = value !== null && value != undefined;
const logic = condition1 && condition2 || condition3;

if (result >= threshold) {
  console.log("Success!");
}

// You should see these as single characters:
// -> => >= <= != !== && || 
// If you see them as separate characters, ligatures aren't working

function compare(a, b) {
  return a === b ? "equal" : "not equal";
}