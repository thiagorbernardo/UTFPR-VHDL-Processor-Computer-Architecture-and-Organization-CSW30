const size = 32;
const max = Math.round(Math.sqrt(size));
console.log(max)
const ram = []

for (let i = 2; i <= size; i++) {
    ram[i] = i
}
console.log(ram)

for (let j = 2; j <= max; j++) {
    for (let i = j+1; i <= size; i++) {
        if (ram[i] % j === 0) {
            ram[i] = undefined
        }
    }
}

console.log(ram)